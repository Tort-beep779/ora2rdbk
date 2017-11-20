package biz.redsoft.ora2rdb;

import java.util.List;
import java.util.TreeSet;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;

import biz.redsoft.ora2rdb.plsqlParser.*;

public class RewritingListener extends plsqlBaseListener {
	TokenStreamRewriter rewriter;
	CommonTokenStream tokens;
	
	public RewritingListener(CommonTokenStream tokens) {
		rewriter = new TokenStreamRewriter(tokens);
		this.tokens = tokens;
	}
	
	void commentBlock(int start_tok_idx, int stop_tok_idx) {
		rewriter.insertBefore(start_tok_idx, "/*");
		rewriter.insertAfter(stop_tok_idx, "*/");
		
		List<Token> multi_line_comments = tokens.getTokens(start_tok_idx, stop_tok_idx, plsqlLexer.MULTI_LINE_COMMENT);
		
		if (multi_line_comments != null)
			for (Token tok : multi_line_comments)
				rewriter.delete(tok);
	}
	
	@Override
	public void exitCreate_table(Create_tableContext ctx) {
		if (ctx.schema_name() != null)
		{
			Schema_nameContext sch = ctx.schema_name();
			rewriter.delete(sch.start, sch.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
		
		if (ctx.physical_properties() != null)
			rewriter.delete(ctx.physical_properties().start, ctx.physical_properties().stop);
		
		if (ctx.lob_storage_clause().size() != 0)
			rewriter.delete(ctx.lob_storage_clause(0).start, ctx.lob_storage_clause(ctx.lob_storage_clause().size() - 1).stop);
		
		String table_name = ctx.tableview_name().getText().toUpperCase();
		
		if (table_name.startsWith("\""))
			table_name = table_name.substring(1, table_name.length() - 1);
		
		if (Ora2rdb.table_not_null_cols.containsKey(table_name))
		{
			TreeSet<String> columns_set = Ora2rdb.table_not_null_cols.get(table_name);
			
			for (Relational_propertiesContext rel_prop_ctx : ctx.relational_properties())
			{
				Column_definitionContext col_def_ctx = rel_prop_ctx.column_definition();
				
				if (col_def_ctx != null)
				{
					String column_name = col_def_ctx.column_name().getText().toUpperCase();

					if (column_name.startsWith("\""))
						column_name = column_name.substring(1, column_name.length() - 1);

					if (columns_set.contains(column_name))
						rewriter.insertAfter(col_def_ctx.stop, " NOT NULL");
				}
			}
		}
	}
	
	@Override
	public void exitColumn_definition(Column_definitionContext ctx) {
		if (ctx.type_spec() != null)
		{
			if (ctx.type_spec().datatype() != null)
				if (ctx.type_spec().datatype().native_datatype_element() != null)
					if (ctx.type_spec().datatype().native_datatype_element().RAW() != null)
					{
						rewriter.replace(ctx.type_spec().start, ctx.type_spec().stop, "BLOB");
						
						if (ctx.default_value_part() != null)
							rewriter.delete(ctx.default_value_part().start, ctx.default_value_part().stop);
					}
		}
	}
	
	@Override
	public void exitDatatype(DatatypeContext ctx) {
		if (ctx.native_datatype_element() != null)
		{
			if (ctx.native_datatype_element().NUMBER() != null)
			{
				if (ctx.precision_part() != null)
				{
					if (ctx.precision_part().ASTERISK() != null)
						rewriter.replace(ctx.precision_part().ASTERISK().getSymbol(), "18");
				}
				else
				{
					rewriter.insertAfter(ctx.native_datatype_element().stop, "(18, 4)");
				}
			}
			else if (ctx.native_datatype_element().FLOAT() != null)
			{
				if (ctx.precision_part() != null)
					rewriter.replace(ctx.start, ctx.stop, "DOUBLE PRECISION");
			}
			else if (ctx.native_datatype_element().TIMESTAMP() != null)
			{
				if (ctx.precision_part() != null)
					rewriter.delete(ctx.precision_part().start, ctx.precision_part().stop);
			}
			else if (ctx.native_datatype_element().VARCHAR2() != null ||
					 ctx.native_datatype_element().VARCHAR() != null)
			{
				if (ctx.precision_part() == null)
					rewriter.insertAfter(ctx.native_datatype_element().stop, "(250)");
			}
			else if (ctx.native_datatype_element().NUMERIC() != null)
			{
				if (ctx.precision_part() == null)
					rewriter.insertAfter(ctx.native_datatype_element().stop, "(18, 4)");
			}
		}
	}
	
	@Override
	public void exitPrecision_part(Precision_partContext ctx) {
		if (ctx.BYTE() != null)
			rewriter.delete(ctx.BYTE().getSymbol());
		else if (ctx.CHAR() != null)
			rewriter.delete(ctx.CHAR().getSymbol());
	}
	
	@Override
	public void exitNative_datatype_element(Native_datatype_elementContext ctx) {
		if (ctx.VARCHAR2() != null || ctx.NVARCHAR2() != null)
			rewriter.replace(ctx.start, "VARCHAR");
		else if (ctx.CLOB() != null)
			rewriter.replace(ctx.start, "BLOB SUB_TYPE 1");
		else if (ctx.NUMBER() != null)
			rewriter.replace(ctx.start, "NUMERIC");
		else if (ctx.BINARY_FLOAT() != null)
			rewriter.replace(ctx.start, "FLOAT");
		else if (ctx.BINARY_DOUBLE() != null)
			rewriter.replace(ctx.start, "DOUBLE PRECISION");
		else if (ctx.NCHAR() != null)
			rewriter.replace(ctx.start, "CHAR");
	}
	
	@Override
	public void exitAlter_table(Alter_tableContext ctx) {
		Schema_nameContext schema_name_ctx = ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
		
		Constraint_clausesContext constraint_clauses_ctx = ctx.constraint_clauses();
		Column_clausesContext column_clauses_ctx = ctx.column_clauses();
		
		if (constraint_clauses_ctx != null)
		{	
			if (constraint_clauses_ctx.out_of_line_constraint().size() != 0)
			{
				Constraint_stateContext constraint_state_ctx = constraint_clauses_ctx.out_of_line_constraint(0).constraint_state();
				
				if (constraint_state_ctx != null)
					rewriter.delete(constraint_state_ctx.start, constraint_state_ctx.stop);
			}
		}
		else if (column_clauses_ctx != null)
		{
			Modify_column_clausesContext modify_column_clauses_ctx = column_clauses_ctx.modify_column_clauses(0);
			
			if (modify_column_clauses_ctx.modify_col_properties().size() != 0)
			{
				Modify_col_propertiesContext modify_col_properties_ctx = modify_column_clauses_ctx.modify_col_properties(0);
				
				if (modify_col_properties_ctx.inline_constraint().size() != 0)
					if (modify_col_properties_ctx.inline_constraint(0).NULL() != null)
						rewriter.delete(ctx.start, ctx.stop);
			}
		}
	}
	
	@Override
	public void exitGeneral_element_part(General_element_partContext ctx) {
		Regular_idContext regular_id_ctx = ctx.id_expression(0).regular_id();
		
		if (regular_id_ctx != null)
		{
			if (regular_id_ctx.REPLACE() != null)
			{
				if (ctx.function_argument().size() == 1)
				{
					Function_argumentContext function_argument_ctx = ctx.function_argument(0);

					if (function_argument_ctx != null)
						if (function_argument_ctx.argument().size() == 2)
							rewriter.insertAfter(function_argument_ctx.argument(1).stop, ", ''");
				}
			}
			else if (regular_id_ctx.LENGTH() != null)
			{
				rewriter.replace(regular_id_ctx.LENGTH().getSymbol(), "CHAR_LENGTH");
			}
		}
	}
	
	@Override
	public void exitReferences_clause(References_clauseContext ctx) {
		Schema_nameContext schema_name_ctx = ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
	}
	
	@Override
	public void exitCreate_index(Create_indexContext ctx) {
		String index_name = ctx.id_expression().getText().toUpperCase();
		
		if (index_name.startsWith("\""))
			index_name = index_name.substring(1, index_name.length() - 1);
		
		if (Ora2rdb.index_names.contains(index_name))
		{
			rewriter.delete(ctx.start, ctx.stop);
			return;
		}
		
		Table_index_clauseContext table_index_clause_ctx = ctx.table_index_clause();
		
		for (Index_exprContext index_expr_ctx : table_index_clause_ctx.index_expr())
		{
			if (index_expr_ctx.unary_expression() != null)
			{
				rewriter.delete(ctx.start, ctx.stop);
				return;
			}
		}
		
		Schema_nameContext schema_name_ctx = ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
		
		schema_name_ctx = table_index_clause_ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(table_index_clause_ctx.PERIOD().getSymbol());
		}
		
		Index_propertiesContext index_properties_ctx = table_index_clause_ctx.index_properties();
		
		if (index_properties_ctx != null)
			rewriter.delete(index_properties_ctx.start, index_properties_ctx.stop);
	}
	
	@Override
	public void exitCreate_sequence(Create_sequenceContext ctx) {
		Sequence_nameContext sequence_name_ctx = ctx.sequence_name();
		Schema_nameContext schema_name_ctx = sequence_name_ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(sequence_name_ctx.PERIOD().getSymbol());
		}
		
		for (Sequence_specContext sequence_spec_ctx : ctx.sequence_spec())
			rewriter.delete(sequence_spec_ctx.start, sequence_spec_ctx.stop);
		
		String set_generator_statements = "";
		
		for (Sequence_start_clauseContext sequence_start_clause_ctx : ctx.sequence_start_clause())
		{
			set_generator_statements += "ALTER SEQUENCE " + sequence_name_ctx.id_expression().getText() +
										" RESTART WITH " + sequence_start_clause_ctx.UNSIGNED_INTEGER().getText() + ";\n";
			
			rewriter.delete(sequence_start_clause_ctx.start, sequence_start_clause_ctx.stop);
		}
		
		rewriter.insertAfter(ctx.stop, "\n" + set_generator_statements);
	}
	
	@Override
	public void exitCreate_view(Create_viewContext ctx) {
		if (ctx.REPLACE() != null)
			rewriter.replace(ctx.REPLACE().getSymbol(), "ALTER");
		
		if (ctx.FORCE() != null)
		{
			rewriter.delete(ctx.FORCE().getSymbol());
			
			if (ctx.NO() != null)
				rewriter.delete(ctx.NO().getSymbol());
		}
		
		Schema_nameContext schema_name_ctx = ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
	}
	
	@Override
	public void exitRegular_id(Regular_idContext ctx) {
		switch (ctx.getText().toUpperCase())
		{
		case "SYSTIMESTAMP":
			rewriter.replace(ctx.start, ctx.stop, "CURRENT_TIMESTAMP");
			break;
		case "SYSDATE":
			rewriter.replace(ctx.start, ctx.stop, "CURRENT_DATE");
		}
	}
	
	@Override
	public void exitFunction_name(Function_nameContext ctx) {
		Schema_nameContext schema_name_ctx = ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
	}
	
	@Override
	public void exitCreate_function_body(Create_function_bodyContext ctx) {
		if (ctx.CREATE() == null)
			rewriter.insertBefore(ctx.FUNCTION().getSymbol(), "CREATE OR ALTER ");
		else if (ctx.REPLACE() != null)
			rewriter.replace(ctx.REPLACE().getSymbol(), "ALTER");
		
		rewriter.insertBefore(ctx.start, "SET TERM ^ ;\n\n");
		
		rewriter.replace(ctx.FUNCTION().getSymbol(), "PROCEDURE");
		
		rewriter.replace(ctx.RETURN().getSymbol(), "RETURNS (RET_VAL");
		rewriter.insertAfter(ctx.type_spec().stop, ")");
		
		if (ctx.IS() != null)
			rewriter.replace(ctx.IS().getSymbol(), "AS");
		
		if (ctx.DECLARE() != null)
			rewriter.delete(ctx.DECLARE().getSymbol());
		
		BodyContext body_ctx = ctx.body();
		
		if (body_ctx != null)
		{
			rewriter.insertBefore(body_ctx.END().getSymbol(), "\nSUSPEND;\n");
			commentBlock(body_ctx.BEGIN().getSymbol().getTokenIndex() + 1, body_ctx.END().getSymbol().getTokenIndex() - 1);
		}
		
		rewriter.replace(ctx.SEMICOLON().getSymbol(), "^\n\nSET TERM ; ^");
	}
	
	@Override
	public void exitParameter(ParameterContext ctx) {
		for (TerminalNode in_node : ctx.IN())
			rewriter.delete(in_node.getSymbol());
	}
	
	@Override
	public void exitPragma_declaration(Pragma_declarationContext ctx) {
		rewriter.delete(ctx.start, ctx.stop);
	}
	
	@Override
	public void exitVariable_declaration(Variable_declarationContext ctx) {
		rewriter.insertBefore(ctx.start, "DECLARE ");
	}
	
	@Override
	public void exitSql_plus_command(Sql_plus_commandContext ctx) {
		rewriter.delete(ctx.start, ctx.stop);
	}
	
	@Override
	public void exitProcedure_name(Procedure_nameContext ctx) {
		Schema_nameContext schema_name_ctx = ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
	}
	
	@Override
	public void exitCreate_procedure_body(Create_procedure_bodyContext ctx) {
		if (ctx.CREATE() == null)
			rewriter.insertBefore(ctx.PROCEDURE().getSymbol(), "CREATE OR ALTER ");
		else if (ctx.REPLACE() != null)
			rewriter.replace(ctx.REPLACE().getSymbol(), "ALTER");
		
		rewriter.insertBefore(ctx.start, "SET TERM ^ ;\n\n");
		
		if (ctx.IS() != null)
			rewriter.replace(ctx.IS().getSymbol(), "AS");
		
		if (ctx.DECLARE() != null)
			rewriter.delete(ctx.DECLARE().getSymbol());
		
		if (ctx.declare_spec().size() != 0)
			commentBlock(ctx.declare_spec(0).start.getTokenIndex(), ctx.declare_spec(ctx.declare_spec().size() - 1).stop.getTokenIndex());
		
		BodyContext body_ctx = ctx.body();
		
		if (body_ctx != null)
			commentBlock(body_ctx.BEGIN().getSymbol().getTokenIndex() + 1, body_ctx.END().getSymbol().getTokenIndex() - 1);
		
		rewriter.replace(ctx.SEMICOLON().getSymbol(), "^\n\nSET TERM ; ^");
	}
	
	@Override
	public void exitTrigger_name(Trigger_nameContext ctx) {
		Schema_nameContext schema_name_ctx = ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
	}
	
	@Override
	public void exitCreate_trigger(Create_triggerContext ctx) {
		rewriter.insertBefore(ctx.start, "SET TERM ^ ;\n\n");
		
		if (ctx.REPLACE() != null)
			rewriter.replace(ctx.REPLACE().getSymbol(), "ALTER");
		
		rewriter.insertBefore(ctx.trigger_body().start, "AS ");
		
		rewriter.replace(ctx.SEMICOLON().getSymbol(), "^\n\nSET TERM ; ^");
	}
	
	@Override
	public void exitReferencing_clause(Referencing_clauseContext ctx) {
		commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
	}
	
	@Override
	public void exitFor_each_row(For_each_rowContext ctx) {
		rewriter.delete(ctx.start, ctx.stop);
	}
	
	@Override
	public void exitTrigger_when_clause(Trigger_when_clauseContext ctx) {
		commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
	}
	
	@Override
	public void exitTrigger_block(Trigger_blockContext ctx) {
		if (ctx.DECLARE() != null)
			rewriter.delete(ctx.DECLARE().getSymbol());
		
		BodyContext body_ctx = ctx.body();
		
		if (body_ctx != null)
			commentBlock(body_ctx.BEGIN().getSymbol().getTokenIndex() + 1, body_ctx.END().getSymbol().getTokenIndex() - 1);
	}
	
	@Override
	public void exitAlter_trigger(Alter_triggerContext ctx) {
		if (ctx.ENABLE() != null)
			rewriter.replace(ctx.ENABLE().getSymbol(), "ACTIVE");
		else if (ctx.DISABLE() != null)
			rewriter.replace(ctx.DISABLE().getSymbol(), "INACTIVE");
	}
}
