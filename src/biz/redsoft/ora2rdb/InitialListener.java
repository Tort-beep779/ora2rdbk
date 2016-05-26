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
						String table_name = ctx.tableview_name().getText().toUpperCase();
						
						if (table_name.startsWith("\""))
							table_name = table_name.substring(1, table_name.length() - 1);
						
						String column_name = modify_col_properties_ctx.column_name().getText().toUpperCase();
						
						if (column_name.startsWith("\""))
							column_name = column_name.substring(1, column_name.length() - 1);
						
						if (Ora2rdb.table_map.containsKey(table_name))
						{
							Ora2rdb.table_map.get(table_name).add(column_name);
						}
						else
						{
							TreeSet<String> columns_set = new TreeSet<String>();
							columns_set.add(column_name);
							Ora2rdb.table_map.put(table_name, columns_set);
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
					{
						String column_name = column_name_ctx.getText().toUpperCase();
						
						if (column_name.startsWith("\""))
							column_name = column_name.substring(1, column_name.length() - 1);
						
						columns_set.add(column_name);
					}
					
					String table_name = ctx.tableview_name().getText().toUpperCase();
					
					if (table_name.startsWith("\""))
						table_name = table_name.substring(1, table_name.length() - 1);
					
					if (Ora2rdb.table_map.containsKey(table_name))
						Ora2rdb.table_map.get(table_name).addAll(columns_set);
					else
						Ora2rdb.table_map.put(table_name, columns_set);
				}
			}
		}
	}
}
