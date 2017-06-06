package biz.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.TreeMap;
import java.util.TreeSet;

import org.antlr.v4.runtime.RuleContext;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.tree.ParseTreeProperty;

import biz.redsoft.ora2rdb.plsqlParser.*;

public class RewritingVisitor extends plsqlBaseVisitor<String> {
	TokenStream tokens;
	String current_table;
	TreeSet<String> current_procedure_args_and_vars = new TreeSet<String>();
	ParseTreeProperty<String> function_names = new ParseTreeProperty<String>();
	ArrayList<String> temporary_tables_ddl = new ArrayList<String>();
	
	public RewritingVisitor(plsqlParser parser) {
		this.tokens = parser.getTokenStream();
	}
	
	String getRuleText(RuleContext ctx) {
		return tokens.getText(ctx);
	}
	
	static class AssocArray {
		static TreeMap<String, AssocArray> type_name_map = new TreeMap<String, AssocArray>();
		static TreeSet<String> used_temporary_table_names = new TreeSet<String>();
		static TreeMap<String, String> array_to_table_map = new TreeMap<String, String>();
		
		String data_type;
		ArrayList<String> index_types_list = new ArrayList<String>();
		
		AssocArray(String name, String type, String index_type) {
			type = Ora2rdb.stripQuotes(type).toUpperCase();
			
			if (type_name_map.containsKey(type))
			{
				AssocArray arr = type_name_map.get(type);
				data_type = arr.data_type;
				index_types_list.addAll(arr.index_types_list);
				index_types_list.add(0, index_type);
			}
			else
			{
				data_type = type;
				index_types_list.add(index_type);
			}
			
			type_name_map.put(Ora2rdb.stripQuotes(name).toUpperCase(), this);
		}
		
		String getTemporaryTableDDL(String name) {
			name = Ora2rdb.stripQuotes(name).toUpperCase();
			String new_name = name;
			
			for (int i = 1; ; i++)
			{
				if (used_temporary_table_names.contains(new_name))
					new_name = name + i;
				else
					break;
			}
			
			used_temporary_table_names.add(new_name);
			array_to_table_map.put(name, new_name);
			String key_fields = "";
			String out = "CREATE GLOBAL TEMPORARY TABLE " + new_name + " (\n";
			
			for (int i = 0; i < index_types_list.size(); i++)
			{
				if (i != 0)
					key_fields += ", ";
				
				out += "\tI" + (i + 1) + " " + index_types_list.get(i) + ",\n";
				key_fields += "I" + (i + 1);
			}
			
			out += "\tVAL " + data_type + ",\n\tCONSTRAINT PK_" + new_name + " PRIMARY KEY (" + key_fields + ")\n);";
			return out;
		}
	}
	
	@Override
	public String visitSql_script(Sql_scriptContext ctx) {
		String out = "";
		
		for (int i = 0; i < ctx.unit_statement().size(); i++)
		{
			String stmt = visit(ctx.unit_statement(i));
			
			if (stmt != null)
			{
				if (i != 0)
					out += "\n";
				
				out += stmt + "\n";
			}
		}
		
		return out;
	}
	
	@Override
	public String visitCreate_table(Create_tableContext ctx) {
		String out = "CREATE TABLE " + getRuleText(ctx.tableview_name()) + " (\n";
		current_table = Ora2rdb.stripQuotes(getRuleText(ctx.tableview_name())).toUpperCase();
		
		for (int i = 0; i < ctx.relational_properties().size(); i++)
		{
			if (i != 0)
				out += ",\n";
			
			out += "\t" + visit(ctx.relational_properties(i));
		}
		
		out += "\n);";
		current_table = null;
		return out;
	}
	
	@Override
	public String visitAlter_table(Alter_tableContext ctx) {
		String out = "ALTER TABLE " + getRuleText(ctx.tableview_name()) + " ";
		
		if (ctx.column_clauses() != null)
			return null;
			//out += visit(ctx.column_clauses());
		else if (ctx.constraint_clauses() != null)
			out += visit(ctx.constraint_clauses());
		
		out += ";";
		return out;
	}
	
	@Override
	public String visitConstraint_clauses(Constraint_clausesContext ctx) {
		String out = "";
		
		if (ctx.ADD() != null)
		{
			out += "ADD ";
			
			for (int i = 0; i < ctx.out_of_line_constraint().size(); i++)
				out += visit(ctx.out_of_line_constraint(i));
		}
		
		return out;
	}
	
	@Override
	public String visitField_spec(Field_specContext ctx) {
		String column_name = getRuleText(ctx.column_name());
		String out = column_name + "\t" + visit(ctx.type_spec());
		column_name = Ora2rdb.stripQuotes(column_name).toUpperCase();
		
		if (current_table != null)
		{
			if (Ora2rdb.table_map.containsKey(current_table))
			{
				TreeSet<String> columns_set = Ora2rdb.table_map.get(current_table);
				
				if (columns_set.contains(column_name))
					out += " NOT NULL";
			}
		}
		
		return out;
	}
	
	@Override
	public String visitType_spec(Type_specContext ctx) {
		if (ctx.datatype() != null)
			return visit(ctx.datatype());
		else
		{
			if (ctx.PERCENT_TYPE() != null)
				return "TYPE OF COLUMN " + getRuleText(ctx.type_name());
			
			return getRuleText(ctx);
		}
	}
	
	@Override
	public String visitOut_of_line_constraint(Out_of_line_constraintContext ctx) {
		String out = "";
		
		if (ctx.CONSTRAINT() != null)
			out += "CONSTRAINT " + getRuleText(ctx.constraint_name()) + " ";
		
		if (ctx.PRIMARY() != null)
		{
			out += "PRIMARY KEY (";
			
			for (int i = 0; i < ctx.column_name().size(); i++)
			{
				if (i != 0)
					out += ", ";
				
				out += visit(ctx.column_name(i));
			}
			
			out += ")";
		}
		else if (ctx.UNIQUE() != null)
		{
			out += "UNIQUE (";
			
			for (int i = 0; i < ctx.column_name().size(); i++)
			{
				if (i != 0)
					out += ", ";
				
				out += visit(ctx.column_name(i));
			}
			
			out += ")";
		}
		else if (ctx.CHECK() != null)
			out += "CHECK (" + visit(ctx.condition()) + ")";
		else if (ctx.FOREIGN() != null)
		{
			out += "FOREIGN KEY (";
			
			for (int i = 0; i < ctx.column_name().size(); i++)
			{
				if (i != 0)
					out += ", ";
				
				out += visit(ctx.column_name(i));
			}
			
			out += ") " + visit(ctx.references_clause());
		}
		
		return out;
	}
	
	@Override
	public String visitReferences_clause(References_clauseContext ctx) {
		String out = "REFERENCES " + getRuleText(ctx.id());
		
		if (ctx.column_name().size() > 0)
		{
			out += " (";
			
			for (int i = 0; i < ctx.column_name().size(); i++)
			{
				if (i != 0)
					out += ", ";
				
				out += visit(ctx.column_name(i));
			}
			
			out += ")";
		}
		
		if (ctx.ON() != null)
		{
			out += " ON DELETE ";
			
			if (ctx.CASCADE() != null)
				out += "CASCADE";
			else
				out += "SET NULL";
		}
		
		return out;
	}
	
	@Override
	public String visitEquality_expression(Equality_expressionContext ctx) {
		String out = visit(ctx.multiset_expression());
		
		for (Is_conditionContext is_cond : ctx.is_condition())
			out += " " + visit(is_cond);
		
		return out;
	}
	
	@Override
	public String visitIs_condition(Is_conditionContext ctx) {
		String out = "IS ";
		
		if (ctx.NOT() != null)
			out += "NOT ";
		
		if (ctx.NULL() != null)
			out += "NULL";
		
		return out;
	}
	
	@Override
	public String visitGeneral_element_part(General_element_partContext ctx) {
		String out = "";
		String name = Ora2rdb.stripQuotes(visit(ctx.id_expression(0))).toUpperCase();
		
		if (AssocArray.array_to_table_map.containsKey(name) &&
			ctx.function_argument().size() != 0)
		{
			String select_stmt = "(SELECT VAL FROM " + AssocArray.array_to_table_map.get(name) + " WHERE ";
			boolean abort = false;
			
			for (int i = 0; i < ctx.function_argument().size(); i++)
			{
				if (ctx.function_argument(i).argument().size() == 1)
				{
					if (i != 0)
						select_stmt += " AND ";
					
					select_stmt += "I" + (i + 1) + " = " + visit(ctx.function_argument(i).argument(0));
				}
				else
				{
					abort = true;
					break;
				}
			}
			
			if (!abort)
			{
				select_stmt += ")";
				return select_stmt;
			}
		}
		
		for (int i = 0; i < ctx.id_expression().size(); i++)
		{
			if (i != 0)
				out += ".";
			
			out += visit(ctx.id_expression(i));
		}
		
		if (ctx.function_argument().size() == 1)
		{
			function_names.put(ctx.function_argument(0), name);
			out += visit(ctx.function_argument(0));
		}
		
		return out;
	}
	
	@Override
	public String visitFunction_argument(Function_argumentContext ctx) {
		String out = "(";
		
		for (int i = 0; i < ctx.argument().size(); i++)
		{
			if (i != 0)
				out += ", ";
			
			out += visit(ctx.argument(i));
		}
		
		String function_name = function_names.get(ctx);
		
		if (function_name != null)
		{
			if (function_name.equals("REPLACE"))
				out += ", ''";
		}
		
		out += ")";
		return out;
	}
	
	@Override
	public String visitQuoted_string(Quoted_stringContext ctx) {
		return getRuleText(ctx);
	}
	
	@Override
	public String visitRelational_expression(Relational_expressionContext ctx) {
		String out = visit(ctx.compound_expression(0));
		
		for (int i = 0; i < ctx.comparison_operator().size(); i++)
			out += " " + getRuleText(ctx.comparison_operator(i)) + " " + visit(ctx.compound_expression(i + 1));
		
		return out;
	}
	
	@Override
	public String visitNumeric(NumericContext ctx) {
		return getRuleText(ctx);
	}
	
	@Override
	public String visitRegular_id(Regular_idContext ctx) {
		if (ctx.LENGTH() != null)
			return "CHAR_LENGTH";
		else
		{
			String id = getRuleText(ctx);
			
			switch (id.toUpperCase())
			{
			case "SYSTIMESTAMP":
				return "CURRENT_TIMESTAMP";
			case "SYSDATE":
				return "CURRENT_DATE";
			}
			
			return id;
		}
	}
	
	@Override
	public String visitColumn_name(Column_nameContext ctx) {
		return getRuleText(ctx.id());
	}
	
	@Override
	public String visitCreate_procedure_body(Create_procedure_bodyContext ctx) {
		String out = "SET TERM ^ ;\n\nCREATE ";
		
		if (ctx.REPLACE() != null)
			out += "OR ALTER ";
		
		out += "PROCEDURE " + visit(ctx.procedure_name());
		
		if (ctx.parameter().size() != 0)
		{
			out += " (";
			
			for (int i = 0; i < ctx.parameter().size(); i++)
			{
				if (i != 0)
					out += ",";
				
				out += "\n\t" + visit(ctx.parameter(i));
			}
			
			out += "\n)";
		}
		
		out += "\nAS\n";
		
		for (Declare_specContext dsc : ctx.declare_spec())
		{
			String decl_spec = visit(dsc);
			
			if (decl_spec != null)
				out += "\tDECLARE " + visit(dsc) + ";\n";
		}
		
		if (ctx.body() != null)
			out += visit(ctx.body());
		
		out += "^\n\nSET TERM ; ^";
		current_procedure_args_and_vars.clear();
		
		String temp_tables_ddl = "";
		
		for (int i = 0; i < temporary_tables_ddl.size(); i++)
			temp_tables_ddl += temporary_tables_ddl.get(i) + "\n\n";
		
		temporary_tables_ddl.clear();
		AssocArray.type_name_map.clear();
		AssocArray.array_to_table_map.clear();
		
		return temp_tables_ddl + out;
	}
	
	@Override
	public String visitProcedure_name(Procedure_nameContext ctx) {
		return getRuleText(ctx.id_expression());
	}
	
	@Override
	public String visitCreate_function_body(Create_function_bodyContext ctx) {
		String out = "SET TERM ^ ;\n\nCREATE ";
		
		if (ctx.REPLACE() != null)
			out += "OR ALTER ";
		
		out += "PROCEDURE " + visit(ctx.function_name());
				
		if (ctx.parameter().size() != 0)
		{
			out += " (";
			
			for (int i = 0; i < ctx.parameter().size(); i++)
			{
				if (i != 0)
					out += ",";
				
				out += "\n\t" + visit(ctx.parameter(i));
			}
			
			out += "\n)";
		}
		
		out += "\nRETURNS (RET_VAL " + visit(ctx.type_spec()) + ")\nAS\n";
		
		for (Declare_specContext dsc : ctx.declare_spec())
			out += "\tDECLARE " + visit(dsc) + ";\n";
		
		if (ctx.body() != null)
			out += visit(ctx.body());
		
		out += "^\n\nSET TERM ; ^";
		current_procedure_args_and_vars.clear();
		return out;
	}
	
	@Override
	public String visitParameter(ParameterContext ctx) {
		String parameter_name = getRuleText(ctx.parameter_name());
		current_procedure_args_and_vars.add(Ora2rdb.stripQuotes(parameter_name).toUpperCase());
		String out = parameter_name;
		
		if (ctx.type_spec() != null)
			out += " " + visit(ctx.type_spec());
		
		if (ctx.default_value_part() != null)
			out += " " + getRuleText(ctx.default_value_part());
		
		return out;
	}
	
	@Override
	public String visitId_expression(Id_expressionContext ctx) {
		String out = "";
		
		if (ctx.regular_id() != null)
			out += visit(ctx.regular_id());
		else
			out += getRuleText(ctx);
		
		if (current_procedure_args_and_vars.contains(Ora2rdb.stripQuotes(out).toUpperCase()))
			out = ":" + out;
		
		return out;
	}
	
	@Override
	public String visitBody(BodyContext ctx) {
		return "BEGIN\n/*\n" + visit(ctx.seq_of_statements()) + "*/\nEND";
	}
	
	@Override
	public String visitSeq_of_statements(Seq_of_statementsContext ctx) {
		String out = "";
		
		for (int i = 0; i < ctx.statement().size(); i++)
		{
			if (i != 0)
				out += "\n";
			
			out += visit(ctx.statement(i));
			
			if (ctx.statement(i).if_statement() == null)
				out += ";";
		}
		
		return out;
	}
	
	@Override
	public String visitInsert_statement(Insert_statementContext ctx) {
		if (ctx.single_table_insert() != null)
			return "INSERT " + visit(ctx.single_table_insert());
		else
			return getRuleText(ctx);
	}
	
	@Override
	public String visitSingle_table_insert(Single_table_insertContext ctx) {
		String out = visit(ctx.insert_into_clause()) + " ";
		
		if (ctx.values_clause() != null)
		{
			out += visit(ctx.values_clause());
			
			if (ctx.static_returning_clause() != null)
				out += " " + getRuleText(ctx.static_returning_clause());
		}
		else
			out += getRuleText(ctx.select_statement());
		
		return out;
	}
	
	@Override
	public String visitInsert_into_clause(Insert_into_clauseContext ctx) {
		String out = "INTO " + getRuleText(ctx.general_table_ref());
		
		if (ctx.column_name().size() != 0)
		{
			out += " (";
			
			for (int i = 0; i < ctx.column_name().size(); i++)
			{
				if (i != 0)
					out += ", ";
				
				out += visit(ctx.column_name(i));
			}
			
			out += ")";
		}
		
		return out;
	}
	
	@Override
	public String visitValues_clause(Values_clauseContext ctx) {
		return "VALUES " + visit(ctx.expression_list());
	}
	
	@Override
	public String visitExpression_list(Expression_listContext ctx) {
		String out = "(";
		
		for (int i = 0; i < ctx.expression().size(); i++)
		{
			if (i != 0)
				out += ", ";
			
			out += visit(ctx.expression(i));
		}
		
		out += ")";
		return out;
	}
	
	@Override
	public String visitQuery_block(Query_blockContext ctx) {
		String out = "SELECT ";
		
		if (ctx.DISTINCT() != null)
			out += "DISTINCT ";
		else if (ctx.UNIQUE() != null)
			out += "UNIQUE ";
		else if (ctx.ALL() != null)
			out += "ALL ";
		
		if (ctx.selected_element().size() != 0)
		{
			for (int i = 0; i < ctx.selected_element().size(); i++)
			{
				if (i != 0)
					out += ", ";
				
				out += visit(ctx.selected_element(i));
			}
		}
		else
			out += "*";
		
		out += "\n" + visit(ctx.from_clause()) + "\n" + visit(ctx.where_clause());
		
		if (ctx.into_clause() != null)
			out += "\n" + visit(ctx.into_clause());
		
		return out;
	}
	
	@Override
	public String visitFrom_clause(From_clauseContext ctx) {
		return "FROM " + visit(ctx.table_ref_list());
	}
	
	@Override
	public String visitTable_ref_list(Table_ref_listContext ctx) {
		String out = "";
		
		for (int i = 0; i < ctx.table_ref().size(); i++)
		{
			if (i != 0)
				out += ", ";
			
			out += getRuleText(ctx.table_ref(i));
		}
		
		return out;
	}
	
	@Override
	public String visitWhere_clause(Where_clauseContext ctx) {
		return "WHERE " + visitChildren(ctx);
	}
	
	@Override
	public String visitLogical_and_expression(Logical_and_expressionContext ctx) {
		String out = "";
		
		for (int i = 0; i < ctx.negated_expression().size(); i++)
		{
			if (i != 0)
				out += " AND ";
			
			out += visit(ctx.negated_expression(i));
		}
		
		return out;
	}
	
	@Override
	public String visitInto_clause(Into_clauseContext ctx) {
		String out = "INTO ";
		
		for (int i = 0; i < ctx.variable_name().size(); i++)
		{
			if (i != 0)
				out += ", ";
			
			out += visit(ctx.variable_name(i));
		}
		
		return out;
	}
	
	@Override
	public String visitReturn_statement(Return_statementContext ctx) {
		return "RET_VAL = " + getRuleText(ctx.condition()) + ";\nSUSPEND";
	}
	
	@Override
	public String visitVariable_declaration(Variable_declarationContext ctx) {
		String var_name = getRuleText(ctx.variable_name());
		String type = Ora2rdb.stripQuotes(visit(ctx.type_spec())).toUpperCase();
		
		if (AssocArray.type_name_map.containsKey(type))
		{
			temporary_tables_ddl.add(AssocArray.type_name_map.get(type).getTemporaryTableDDL(var_name));
			return null;
		}
		
		String out = var_name + " " + type;
		
		if (ctx.NOT() != null)
			out += " NOT NULL";
		
		if (ctx.default_value_part() != null)
			out += " " + getRuleText(ctx.default_value_part());
		
		current_procedure_args_and_vars.add(Ora2rdb.stripQuotes(var_name).toUpperCase());
		return out;
	}
	
	@Override
	public String visitDatatype(DatatypeContext ctx) {
		String out = "";
		
		if (ctx.native_datatype_element().NUMBER() != null)
		{
			out += "NUMERIC";
			
			if (ctx.precision_part() == null)
				out += "(18,4)";
		}
		else if (ctx.native_datatype_element().VARCHAR2() != null)
			out += "VARCHAR";
		else if (ctx.native_datatype_element().CLOB() != null)
			out += "BLOB SUB_TYPE TEXT";
		else if (ctx.native_datatype_element().RAW() != null)
			out += "BLOB";
		else
			out += getRuleText(ctx.native_datatype_element());
		
		if (ctx.precision_part() != null && ctx.native_datatype_element().RAW() == null && ctx.native_datatype_element().TIMESTAMP() == null)
			out += visit(ctx.precision_part());
		
		return out;
	}
	
	@Override
	public String visitPrecision_part(Precision_partContext ctx) {
		String out = "(";
		
		if (ctx.ASTERISK() != null)
			out += "18";
		else
			out += getRuleText(ctx.numeric(0));
		
		if (ctx.numeric().size() > 1)
			out += "," + getRuleText(ctx.numeric(1));
		
		out += ")";
		return out;
	}
	
	@Override
	public String visitComment(CommentContext ctx) {
		String out = "COMMENT ON ";
		
		if (ctx.COLUMN() != null)
			out += "COLUMN " + getRuleText(ctx.tableview_name()) + "." + getRuleText(ctx.column_name());
		else if (ctx.TABLE() != null)
			out += "TABLE " + getRuleText(ctx.tableview_name());
		
		out += " IS " + getRuleText(ctx.quoted_string()) + ";";
		return out;
	}
	
	@Override
	public String visitCreate_sequence(Create_sequenceContext ctx) {
		String seq_name = visit(ctx.sequence_name());
		String out = "CREATE SEQUENCE " + seq_name + ";";
		
		if (ctx.sequence_start_clause().size() != 0)
			out += "\nALTER SEQUENCE " + seq_name + " RESTART WITH " + ctx.sequence_start_clause(0).UNSIGNED_INTEGER().getText() + ";";
		
		return out;
	}
	
	@Override
	public String visitSequence_name(Sequence_nameContext ctx) {
		return getRuleText(ctx.id_expression());
	}
	
	@Override
	public String visitCreate_view(Create_viewContext ctx) {
		String out = "CREATE ";
		
		if (ctx.REPLACE() != null)
			out += "OR ALTER ";
		
		out += "VIEW " + getRuleText(ctx.tableview_name()) + " (";
		
		for (int i = 0; i < ctx.id_expression().size(); i++)
		{
			if (i != 0)
				out += ",";
			
			out += "\n\t" + getRuleText(ctx.id_expression(i));
		}
		
		out += "\n)\nAS\n" + visit(ctx.subquery()) + ";";
		return out;
	}
	
	@Override
	public String visitCreate_index(Create_indexContext ctx) {
		String index_name = getRuleText(ctx.id_expression());
		
		if (Ora2rdb.index_names.contains(Ora2rdb.stripQuotes(index_name).toUpperCase()))
			return null;
		
		String out = "CREATE ";
		
		if (ctx.UNIQUE() != null)
			out += "UNIQUE ";
		
		out += "INDEX " + index_name + " ON " + visit(ctx.table_index_clause()) + ";";
		return out;
	}
	
	@Override
	public String visitTable_index_clause(Table_index_clauseContext ctx) {
		String out = getRuleText(ctx.tableview_name()) + " (";
		
		for (int i = 0; i < ctx.index_expr().size(); i++)
		{
			if (i != 0)
				out += ", ";
			
			out += getRuleText(ctx.index_expr(i));
		}
		
		out += ")";
		return out;
	}
	
	@Override
	public String visitCreate_trigger(Create_triggerContext ctx) {
		String out = "SET TERM ^ ;\n\nCREATE ";
		
		if (ctx.REPLACE() != null)
			out += "OR ALTER ";
		
		out += "TRIGGER " + visit(ctx.trigger_name());
		
		if (ctx.simple_dml_trigger() != null)
			out += " " + visit(ctx.simple_dml_trigger());
		
		out += "\nAS\n" + visit(ctx.trigger_body()) + "^\n\nSET TERM ; ^";
		return out;
	}
	
	@Override
	public String visitTrigger_name(Trigger_nameContext ctx) {
		return getRuleText(ctx.id_expression());
	}
	
	@Override
	public String visitSimple_dml_trigger(Simple_dml_triggerContext ctx) {
		String out = "";
		
		if (ctx.BEFORE() != null)
			out += "BEFORE";
		else if (ctx.AFTER() != null)
			out += "AFTER";
		else if (ctx.INSTEAD() != null)
			out += "INSTEAD OF";
		
		out += " " + visit(ctx.dml_event_clause());
		return out;
	}
	
	@Override
	public String visitDml_event_clause(Dml_event_clauseContext ctx) {
		String out = "";
		
		for (int i = 0; i < ctx.dml_event_element().size(); i++)
		{
			if (i != 0)
				out += " OR ";
			
			out += visit(ctx.dml_event_element(i));
		}
		
		out += " ON " + visit(ctx.tableview_name());
		return out;
	}
	
	@Override
	public String visitDml_event_element(Dml_event_elementContext ctx) {
		if (ctx.DELETE() != null)
			return "DELETE";
		else if (ctx.INSERT() != null)
			return "INSERT";
		else
			return "UPDATE";
	}
	
	@Override
	public String visitFunction_call(Function_callContext ctx) {
		String out = getRuleText(ctx.routine_name());
		
		if (ctx.function_argument() != null)
			out += visit(ctx.function_argument());
		
		return out;
	}
	
	@Override
	public String visitIf_statement(If_statementContext ctx) {
		String out = "IF (" + visit(ctx.condition()) + ") THEN\n";
		
		if (ctx.seq_of_statements().statement().size() > 1)
			out += "BEGIN\n" + visit(ctx.seq_of_statements()) + "\nEND";
		else 
			out += visit(ctx.seq_of_statements());
		
		for (int i = 0; i < ctx.elsif_part().size(); i++)
			out += "\n" + visit(ctx.elsif_part(i));
		
		if (ctx.else_part() != null)
			out += "\n" + visit(ctx.else_part());
		
		return out;
	}
	
	@Override
	public String visitElse_part(Else_partContext ctx) {
		String out = "ELSE\n";
		
		if (ctx.seq_of_statements().statement().size() > 1)
			out += "BEGIN\n" + visit(ctx.seq_of_statements()) + "\nEND";
		else 
			out += visit(ctx.seq_of_statements());
		
		return out;
	}
	
	@Override
	public String visitElsif_part(Elsif_partContext ctx) {
		String out = "ELSE IF (" + visit(ctx.condition()) + ") THEN\n";
		
		if (ctx.seq_of_statements().statement().size() > 1)
			out += "BEGIN\n" + visit(ctx.seq_of_statements()) + "\nEND";
		else 
			out += visit(ctx.seq_of_statements());
		
		return out;
	}
	
	@Override
	public String visitTable_type_dec(Table_type_decContext ctx) {
		if (ctx.TABLE() != null)
		{
			if (ctx.table_indexed_by_part() != null)
				new AssocArray(getRuleText(ctx.type_name()), visit(ctx.type_spec()), visit(ctx.table_indexed_by_part().type_spec()));
		}
		
		return null;
	}
	
	@Override
	public String visitAssignment_statement(Assignment_statementContext ctx) {
		String out = "";
		
		if (ctx.general_element() != null)
		{
			General_element_partContext gen_elem_part_ctx = ctx.general_element().general_element_part(0);
			String name = Ora2rdb.stripQuotes(visit(gen_elem_part_ctx.id_expression(0))).toUpperCase();
			
			if (AssocArray.array_to_table_map.containsKey(name) &&
					gen_elem_part_ctx.function_argument().size() != 0)
			{
				String insert_stmt = "INSERT INTO " + AssocArray.array_to_table_map.get(name) + " VALUES (";
				boolean abort = false;
				
				for (Function_argumentContext func_arg_ctx : gen_elem_part_ctx.function_argument())
				{
					if (func_arg_ctx.argument().size() == 1)
						insert_stmt += visit(func_arg_ctx.argument(0)) + ", ";
					else
					{
						abort = true;
						break;
					}
				}
				
				if (!abort)
				{
					insert_stmt += visit(ctx.expression()) + ")";
					return insert_stmt;
				}
			}
			
			out += visit(ctx.general_element());
		}
		else
			out += getRuleText(ctx.bind_variable());
		
		if (out.startsWith(":"))
			out = out.substring(1);
		
		out += " = " + visit(ctx.expression());
		return out;
	}
}
