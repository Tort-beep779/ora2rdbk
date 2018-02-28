package biz.redsoft.ora2rdb;

import java.util.TreeSet;

import biz.redsoft.ora2rdb.plsqlParser.*;

public class InitialListener extends plsqlBaseListener {
	@Override
	public void enterAlter_table(Alter_tableContext ctx) {
		Column_clausesContext columns_ctx = ctx.column_clauses();
		Constraint_clausesContext constraint_clauses_ctx = ctx.constraint_clauses();
		
		if (columns_ctx != null)
		{
			Modify_column_clausesContext modify_column_clauses_ctx = columns_ctx.modify_column_clauses(0);
			
			if (modify_column_clauses_ctx.modify_col_properties().size() != 0)
			{
				Modify_col_propertiesContext modify_col_properties_ctx = modify_column_clauses_ctx.modify_col_properties(0);
				
				if (modify_col_properties_ctx.inline_constraint().size() != 0)
				{
					Inline_constraintContext inline_constraint_ctx = modify_col_properties_ctx.inline_constraint(0);
					
					if (inline_constraint_ctx.NOT() != null && inline_constraint_ctx.NULL() != null)
					{
						String table_name = Ora2rdb.getRealName(ctx.tableview_name().getText());
						String column_name = Ora2rdb.getRealName(modify_col_properties_ctx.column_name().getText());
						
						if (Ora2rdb.table_not_null_cols.containsKey(table_name))
						{
							Ora2rdb.table_not_null_cols.get(table_name).add(column_name);
						}
						else
						{
							TreeSet<String> columns_set = new TreeSet<String>();
							columns_set.add(column_name);
							Ora2rdb.table_not_null_cols.put(table_name, columns_set);
						}
					}
				}
			}
		}
		else if (constraint_clauses_ctx != null)
		{
			if (constraint_clauses_ctx.out_of_line_constraint().size() != 0)
			{
				Out_of_line_constraintContext out_of_line_constraint_ctx = constraint_clauses_ctx.out_of_line_constraint(0);
				
				if (out_of_line_constraint_ctx.PRIMARY() != null)
				{
					TreeSet<String> columns_set = new TreeSet<String>();
					
					for (Column_nameContext column_name_ctx : out_of_line_constraint_ctx.column_name())
						columns_set.add(Ora2rdb.getRealName(column_name_ctx.getText()));
					
					String table_name = Ora2rdb.getRealName(ctx.tableview_name().getText());
					
					if (Ora2rdb.table_not_null_cols.containsKey(table_name))
						Ora2rdb.table_not_null_cols.get(table_name).addAll(columns_set);
					else
						Ora2rdb.table_not_null_cols.put(table_name, columns_set);
				}
				
				if (out_of_line_constraint_ctx.PRIMARY() != null || 
					out_of_line_constraint_ctx.FOREIGN() != null ||
					out_of_line_constraint_ctx.UNIQUE() != null)
				{
					Ora2rdb.index_names.add(Ora2rdb.getRealName(out_of_line_constraint_ctx.constraint_name().getText()));
				}
			}
		}
	}
	
	@Override
	public void enterCreate_procedure_body(Create_procedure_bodyContext ctx) {
		Ora2rdb.procedures_names.add(Ora2rdb.getRealName(ctx.procedure_name().id_expression().getText()));
	}
	
	@Override
	public void enterCreate_view(Create_viewContext ctx) {
		Ora2rdb.views.put(Ora2rdb.getRealName(ctx.tableview_name().getText()), new View(ctx));
	}
}
