package biz.redsoft.ora2rdb;

import java.util.TreeMap;
import java.util.TreeSet;

import org.antlr.v4.runtime.*;

import biz.redsoft.ora2rdb.plsqlParser.*;

public class RewritingListener extends plsqlBaseListener {
	TokenStreamRewriter rewriter;
	TokenStream tokens;
	TreeMap<String, TreeSet<String>> table_map;
	
	public RewritingListener(TokenStream tokens, TreeMap<String, TreeSet<String>> table_map) {
		rewriter = new TokenStreamRewriter(tokens);
		this.tokens = tokens;
		this.table_map = table_map;
	}
	
	@Override
	public void enterCreate_table(Create_tableContext ctx) {
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
		
		if (table_map.containsKey(table_name))
		{
			TreeSet<String> columns_set = table_map.get(table_name);
			
			for (Field_specContext field_ctx : ctx.field_spec())
			{
				String column_name = field_ctx.column_name().getText().toUpperCase();
				
				if (column_name.startsWith("\""))
					column_name = column_name.substring(1, column_name.length() - 1);
				
				if (columns_set.contains(column_name))
					rewriter.insertAfter(field_ctx.stop, " NOT NULL");
			}
		}
	}
	
	@Override
	public void enterField_spec(Field_specContext ctx) {
		if (ctx.type_spec() != null)
		{
			if (ctx.type_spec().datatype() != null)
				if (ctx.type_spec().datatype().native_datatype_element() != null)
					if (ctx.type_spec().datatype().native_datatype_element().RAW() != null)
					{
						rewriter.replace(ctx.type_spec().start, ctx.type_spec().stop, "SMALLINT [0:10]");
						
						if (ctx.default_value_part() != null)
							rewriter.delete(ctx.default_value_part().start, ctx.default_value_part().stop);
					}
		}
	}
	
	@Override
	public void enterDatatype(DatatypeContext ctx) {
		if (ctx.native_datatype_element() != null)
		{
			if (ctx.native_datatype_element().NUMBER() != null)
			{
				if (ctx.precision_part() != null)
				{
					if (ctx.precision_part().ASTERISK() == null)
						rewriter.replace(ctx.native_datatype_element().start, ctx.native_datatype_element().stop, "NUMERIC");
					else
						rewriter.replace(ctx.start, ctx.stop, "SMALLINT");
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
		}
	}
	
	@Override
	public void enterPrecision_part(Precision_partContext ctx) {
		if (ctx.BYTE() != null)
			rewriter.delete(ctx.BYTE().getSymbol());
		else if (ctx.CHAR() != null)
			rewriter.delete(ctx.CHAR().getSymbol());
	}
	
	@Override
	public void enterNative_datatype_element(Native_datatype_elementContext ctx) {
		if (ctx.VARCHAR2() != null)
			rewriter.replace(ctx.start, "VARCHAR");
		else if (ctx.DATE() != null)
			rewriter.replace(ctx.start, "TIMESTAMP");
		else if (ctx.CLOB() != null)
			rewriter.replace(ctx.start, "BLOB SUB_TYPE 1");
	}
	
	@Override
	public void enterAlter_table(Alter_tableContext ctx) {
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
	public void enterGeneral_element_part(General_element_partContext ctx) {
		Regular_idContext regular_id_ctx = ctx.id_expression(0).regular_id();
		
		if (regular_id_ctx != null)
		{
			if (regular_id_ctx.REPLACE() != null)
			{
				Function_argumentContext function_argument_ctx = ctx.function_argument();
				
				if (function_argument_ctx != null)
					if (function_argument_ctx.argument().size() == 2)
						rewriter.insertAfter(function_argument_ctx.argument(1).stop, ", ''");
			}
			else if (regular_id_ctx.LENGTH() != null)
			{
				rewriter.replace(regular_id_ctx.LENGTH().getSymbol(), "CHAR_LENGTH");
			}
		}
	}
	
	@Override
	public void enterReferences_clause(References_clauseContext ctx) {
		Schema_nameContext schema_name_ctx = ctx.schema_name();
		
		if (schema_name_ctx != null)
		{
			rewriter.delete(schema_name_ctx.start, schema_name_ctx.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
	}
}
