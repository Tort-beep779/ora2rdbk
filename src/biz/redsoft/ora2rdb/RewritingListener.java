package biz.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;

import biz.redsoft.ora2rdb.plsqlParser.*;

public class RewritingListener extends plsqlBaseListener {
	TokenStreamRewriter rewriter;
	CommonTokenStream tokens;
	ArrayList<String> current_trigger_fields = new ArrayList<String>();
	
	public RewritingListener(CommonTokenStream tokens) {
		rewriter = new TokenStreamRewriter(tokens);
		this.tokens = tokens;
	}
	
	void insertBefore(ParserRuleContext ctx, Object text) {
		rewriter.insertBefore(ctx.start, text);
	}
	
	void insertBefore(TerminalNode term, Object text) {
		rewriter.insertBefore(term.getSymbol(), text);
	}
	
	void insertAfter(ParserRuleContext ctx, Object text) {
		rewriter.insertAfter(ctx.stop, text);
	}
	
	void insertAfter(TerminalNode term, Object text) {
		rewriter.insertAfter(term.getSymbol(), text);
	}
	
	void replace(ParserRuleContext ctx, Object text) {
		if (ctx != null)
			rewriter.replace(ctx.start, ctx.stop, text);
	}
	
	void replace(TerminalNode term, Object text) {
		if (term != null)
			rewriter.replace(term.getSymbol(), text);
	}
	
	void delete(ParserRuleContext ctx) {
		if (ctx != null)
			rewriter.delete(ctx.start, ctx.stop);
	}
	
	void delete(TerminalNode term) {
		if (term != null)
			rewriter.delete(term.getSymbol());
	}
	
	void delete(List<? extends ParserRuleContext> ctx_list) {
		if (ctx_list.size() != 0)
			rewriter.delete(ctx_list.get(0).start, ctx_list.get(ctx_list.size() - 1).stop);
	}
	
	void commentBlock(int start_tok_idx, int stop_tok_idx) {
		rewriter.insertBefore(start_tok_idx, "/*");
		rewriter.insertAfter(stop_tok_idx, "*/");
		
		List<Token> multi_line_comments = tokens.getTokens(start_tok_idx, stop_tok_idx, plsqlLexer.MULTI_LINE_COMMENT);
		
		if (multi_line_comments != null)
			for (Token tok : multi_line_comments)
				rewriter.delete(tok);
	}
	
	String getRuleText(RuleContext ctx) {
		return tokens.getText(ctx);
	}
	
	@Override
	public void exitCreate_table(Create_tableContext ctx) {
		delete(ctx.schema_name());
		delete(ctx.PERIOD());
		
		delete(ctx.physical_properties());
		delete(ctx.lob_storage_clause());
		
		String table_name = Ora2rdb.getRealName(getRuleText(ctx.tableview_name()));
		
		if (Ora2rdb.table_not_null_cols.containsKey(table_name))
		{
			TreeSet<String> columns_set = Ora2rdb.table_not_null_cols.get(table_name);
			
			for (Relational_propertiesContext rel_prop_ctx : ctx.relational_properties())
			{
				Column_definitionContext col_def_ctx = rel_prop_ctx.column_definition();
				
				if (col_def_ctx != null)
				{
					String column_name = Ora2rdb.getRealName(getRuleText(col_def_ctx.column_name()));

					if (columns_set.contains(column_name))
						insertAfter(col_def_ctx, " NOT NULL");
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
						replace(ctx.type_spec(), "BLOB");
						delete(ctx.default_value_part());
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
					replace(ctx.precision_part().ASTERISK(), "18");
				else
					insertAfter(ctx.native_datatype_element(), "(18, 4)");
			}
			else if (ctx.native_datatype_element().FLOAT() != null)
			{
				if (ctx.precision_part() != null)
					replace(ctx, "DOUBLE PRECISION");
			}
			else if (ctx.native_datatype_element().TIMESTAMP() != null)
			{
				delete(ctx.precision_part());
			}
			else if (ctx.native_datatype_element().VARCHAR2() != null ||
					 ctx.native_datatype_element().VARCHAR() != null)
			{
				if (ctx.precision_part() == null)
					insertAfter(ctx.native_datatype_element(), "(250)");
			}
			else if (ctx.native_datatype_element().NUMERIC() != null)
			{
				if (ctx.precision_part() == null)
					insertAfter(ctx.native_datatype_element(), "(18, 4)");
			}
		}
	}
	
	@Override
	public void exitPrecision_part(Precision_partContext ctx) {
		delete(ctx.BYTE());
		delete(ctx.CHAR());
	}
	
	@Override
	public void exitNative_datatype_element(Native_datatype_elementContext ctx) {
		if (ctx.VARCHAR2() != null || ctx.NVARCHAR2() != null)
			replace(ctx, "VARCHAR");
		else if (ctx.CLOB() != null)
			replace(ctx, "BLOB SUB_TYPE 1");
		else if (ctx.NUMBER() != null)
			replace(ctx, "NUMERIC");
		else if (ctx.BINARY_FLOAT() != null)
			replace(ctx, "FLOAT");
		else if (ctx.BINARY_DOUBLE() != null)
			replace(ctx, "DOUBLE PRECISION");
		else if (ctx.NCHAR() != null)
			replace(ctx, "CHAR");
	}
	
	@Override
	public void exitTableview_name(Tableview_nameContext ctx) {
		if (ctx.id_expression() != null)
		{
			delete(ctx.id().id_expression());
			delete(ctx.PERIOD());
		}
	}
	
	@Override
	public void exitOut_of_line_constraint(Out_of_line_constraintContext ctx) {
		delete(ctx.constraint_state());
	}
	
	@Override
	public void exitAlter_table(Alter_tableContext ctx) {
		delete(ctx.schema_name());
		delete(ctx.PERIOD());
		
		Constraint_clausesContext constraint_clauses_ctx = ctx.constraint_clauses();
		Column_clausesContext column_clauses_ctx = ctx.column_clauses();
		
		if (constraint_clauses_ctx != null)
		{	
			if (constraint_clauses_ctx.out_of_line_constraint().size() != 0)
			{
				Constraint_stateContext constraint_state_ctx = constraint_clauses_ctx.out_of_line_constraint(0).constraint_state();
				delete(constraint_state_ctx);
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
						delete(ctx);
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
							insertAfter(function_argument_ctx.argument(1), ", ''");
				}
			}
			
			replace(regular_id_ctx.LENGTH(), "CHAR_LENGTH");
		}
	}
	
	@Override
	public void exitReferences_clause(References_clauseContext ctx) {
		delete(ctx.schema_name());
		delete(ctx.PERIOD());
	}
	
	@Override
	public void exitCreate_index(Create_indexContext ctx) {
		String index_name = Ora2rdb.getRealName(getRuleText(ctx.id_expression()));
		
		if (Ora2rdb.index_names.contains(index_name))
		{
			delete(ctx);
			return;
		}
		
		Table_index_clauseContext table_index_clause_ctx = ctx.table_index_clause();
		
		for (Index_exprContext index_expr_ctx : table_index_clause_ctx.index_expr())
		{
			if (index_expr_ctx.unary_expression() != null)
			{
				delete(ctx);
				return;
			}
		}
		
		delete(ctx.schema_name());
		delete(ctx.PERIOD());
		delete(table_index_clause_ctx.schema_name());
		delete(table_index_clause_ctx.PERIOD());
		delete(table_index_clause_ctx.index_properties());
	}
	
	@Override
	public void exitCreate_sequence(Create_sequenceContext ctx) {
		Sequence_nameContext sequence_name_ctx = ctx.sequence_name();
		
		delete(sequence_name_ctx.schema_name());
		delete(sequence_name_ctx.PERIOD());
		
		for (Sequence_specContext sequence_spec_ctx : ctx.sequence_spec())
			delete(sequence_spec_ctx);
		
		String set_generator_statements = "";
		
		for (Sequence_start_clauseContext sequence_start_clause_ctx : ctx.sequence_start_clause())
		{
			set_generator_statements += "ALTER SEQUENCE " + getRuleText(sequence_name_ctx.id_expression()) +
										" RESTART WITH " + sequence_start_clause_ctx.UNSIGNED_INTEGER().getText() + ";\n";
			
			delete(sequence_start_clause_ctx);
		}
		
		insertAfter(ctx, "\n" + set_generator_statements);
	}
	
	@Override
	public void exitCreate_view(Create_viewContext ctx) {
		replace(ctx.REPLACE(), "ALTER");
		delete(ctx.FORCE());
		delete(ctx.NO());
		delete(ctx.schema_name());
		delete(ctx.PERIOD());
	}
	
	@Override
	public void exitSubquery_restriction_clause(Subquery_restriction_clauseContext ctx) {
		delete(ctx);
	}
	
	@Override
	public void exitRegular_id(Regular_idContext ctx) {
		switch (getRuleText(ctx).toUpperCase())
		{
		case "SYSTIMESTAMP":
			replace(ctx, "CURRENT_TIMESTAMP");
			break;
		case "SYSDATE":
			replace(ctx, "CURRENT_DATE");
		}
	}
	
	@Override
	public void exitFunction_name(Function_nameContext ctx) {
		delete(ctx.schema_name());
		delete(ctx.PERIOD());
	}
	
	@Override
	public void exitCreate_function_body(Create_function_bodyContext ctx) {
		if (ctx.CREATE() == null)
			insertBefore(ctx.FUNCTION(), "CREATE OR ALTER ");
		
		replace(ctx.REPLACE(), "ALTER");
		insertBefore(ctx, "SET TERM ^ ;\n\n");
		replace(ctx.FUNCTION(), "PROCEDURE");
		
		replace(ctx.RETURN(), "RETURNS (RET_VAL");
		insertAfter(ctx.type_spec(), ")");
		
		replace(ctx.IS(), "AS");
		delete(ctx.DECLARE());
		
		BodyContext body_ctx = ctx.body();
		
		if (body_ctx != null)
		{
			insertBefore(body_ctx.END(), "\nSUSPEND;\n");
			commentBlock(body_ctx.BEGIN().getSymbol().getTokenIndex() + 1, body_ctx.END().getSymbol().getTokenIndex() - 1);
		}
		
		replace(ctx.SEMICOLON(), "^\n\nSET TERM ; ^");
	}
	
	@Override
	public void exitParameter(ParameterContext ctx) {
		for (TerminalNode in_node : ctx.IN())
			delete(in_node);
	}
	
	@Override
	public void exitPragma_declaration(Pragma_declarationContext ctx) {
		delete(ctx);
	}
	
	@Override
	public void exitVariable_declaration(Variable_declarationContext ctx) {
		insertBefore(ctx, "DECLARE ");
	}
	
	@Override
	public void exitSql_plus_command(Sql_plus_commandContext ctx) {
		delete(ctx);
	}
	
	@Override
	public void exitProcedure_name(Procedure_nameContext ctx) {
		delete(ctx.schema_name());
		delete(ctx.PERIOD());
	}
	
	@Override
	public void exitCreate_procedure_body(Create_procedure_bodyContext ctx) {
		if (ctx.CREATE() == null)
			insertBefore(ctx.PROCEDURE(), "CREATE OR ALTER ");

		replace(ctx.REPLACE(), "ALTER");
		insertBefore(ctx, "SET TERM ^ ;\n\n");
		replace(ctx.IS(), "AS");
		delete(ctx.DECLARE());
		
		if (ctx.declare_spec().size() != 0)
			commentBlock(ctx.declare_spec(0).start.getTokenIndex(), ctx.declare_spec(ctx.declare_spec().size() - 1).stop.getTokenIndex());
		
		BodyContext body_ctx = ctx.body();
		
		if (body_ctx != null)
			commentBlock(body_ctx.BEGIN().getSymbol().getTokenIndex() + 1, body_ctx.END().getSymbol().getTokenIndex() - 1);
		
		replace(ctx.SEMICOLON(), "^\n\nSET TERM ; ^");
	}
	
	@Override
	public void exitType_spec(Type_specContext ctx) {
		if (ctx.PERCENT_TYPE() != null)
			replace(ctx, "TYPE OF COLUMN " + getRuleText(ctx.type_name()));
	}
	
	@Override
	public void exitTrigger_name(Trigger_nameContext ctx) {
		delete(ctx.schema_name());
		delete(ctx.PERIOD());
	}
	
	@Override
	public void exitCreate_trigger(Create_triggerContext ctx) {
		insertBefore(ctx, "SET TERM ^ ;\n\n");
		replace(ctx.REPLACE(), "ALTER");
		insertBefore(ctx.trigger_body(), "AS ");
		replace(ctx.SEMICOLON(), "^\n\nSET TERM ; ^");
	}
	
	@Override
	public void exitReferencing_clause(Referencing_clauseContext ctx) {
		commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
	}
	
	@Override
	public void exitFor_each_row(For_each_rowContext ctx) {
		delete(ctx);
	}
	
	@Override
	public void exitTrigger_when_clause(Trigger_when_clauseContext ctx) {
		commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
	}
	
	@Override
	public void exitDml_event_element(Dml_event_elementContext ctx) {
		for (Column_nameContext col_name_ctx : ctx.column_name())
			current_trigger_fields.add(getRuleText(col_name_ctx));
		
		delete(ctx.OF());
		delete(ctx.column_name());
	}
	
	@Override
	public void exitBody(BodyContext ctx) {
		if (current_trigger_fields.size() > 0)
		{
			String update_condition = "\nIF (";
			
			for (int i = 0; i < current_trigger_fields.size(); i++)
			{
				if (i != 0)
					update_condition += " OR ";
				
				update_condition += "NEW." + current_trigger_fields.get(i) + " <> OLD." + current_trigger_fields.get(i);
			}
			
			update_condition += ") THEN";
			
			if (ctx.seq_of_statements().statement().size() > 1)
				update_condition += "\nBEGIN";
				
			insertAfter(ctx.BEGIN(), update_condition);
				
			if (ctx.seq_of_statements().statement().size() > 1)
				insertBefore(ctx.END(), "END\n");
			
			current_trigger_fields.clear();
		}
	}
	
	@Override
	public void exitTrigger_block(Trigger_blockContext ctx) {
		delete(ctx.DECLARE());
		
		BodyContext body_ctx = ctx.body();
		
		if (body_ctx != null)
			commentBlock(body_ctx.BEGIN().getSymbol().getTokenIndex() + 1, body_ctx.END().getSymbol().getTokenIndex() - 1);
	}
	
	@Override
	public void exitAlter_trigger(Alter_triggerContext ctx) {
		replace(ctx.ENABLE(), "ACTIVE");
		replace(ctx.DISABLE(), "INACTIVE");
	}
	
	@Override
	public void exitLabel_name(Label_nameContext ctx) {
		delete(ctx);
	}
}
