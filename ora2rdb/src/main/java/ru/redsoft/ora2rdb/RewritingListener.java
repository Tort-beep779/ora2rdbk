package ru.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;
import java.util.TreeSet;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.TerminalNode;

import ru.redsoft.ora2rdb.PlSqlParser.*;

public class RewritingListener extends PlSqlParserBaseListener {
    TokenStreamRewriter rewriter;
    CommonTokenStream tokens;
    String parent_procedure_name;


    View current_view;
    PLSQLBlock current_plsql_block;

    ArrayList<Create_sequenceContext> sequences = new ArrayList<Create_sequenceContext>();
    ArrayList<Create_tableContext> tables = new ArrayList<Create_tableContext>();
    ArrayList<Comment_on_tableContext> comments = new ArrayList<Comment_on_tableContext>();
    ArrayList<Alter_tableContext> alter_tables = new ArrayList<Alter_tableContext>();
    ArrayList<Create_indexContext> create_indexes = new ArrayList<Create_indexContext>();
    ArrayList<Create_function_bodyContext> create_functions = new ArrayList<Create_function_bodyContext>();
    ArrayList<Create_procedure_bodyContext> create_procedures = new ArrayList<Create_procedure_bodyContext>();
    ArrayList<Create_triggerContext> create_triggers = new ArrayList<Create_triggerContext>();
    ArrayList<Alter_triggerContext> alter_triggers = new ArrayList<Alter_triggerContext>();

    ArrayList<String> create_temporary_tables = new ArrayList<String>();
    ArrayList<String> loop_index_names = new ArrayList<String>();

    boolean containsException = false;
    boolean exceptionExist = false;

    public RewritingListener(CommonTokenStream tokens) {
        rewriter = new TokenStreamRewriter(tokens);
        this.tokens = tokens;
    }

    public String getText() {
        StringBuilder out = new StringBuilder();

        for (Create_sequenceContext sequence : sequences)
            out.append(getRewriterText(sequence)).append("\n\n");

        for (Create_tableContext table : tables)
            out.append(getRewriterText(table)).append("\n\n");

        ArrayList<View> views = View.sort(Ora2rdb.views.values());

        for (View view : views)
            out.append(getRewriterText(view.ctx)).append("\n\n");

        for (Comment_on_tableContext comment : comments)
            out.append(getRewriterText(comment)).append("\n\n");

        for (Alter_tableContext alter_table : alter_tables)
            out.append(getRewriterText(alter_table)).append("\n\n");

        for (Create_indexContext create_index : create_indexes)
            out.append(getRewriterText(create_index)).append("\n\n");

        for (String create_temporary_table : create_temporary_tables)
            out.append(create_temporary_table);

        boolean plsql = !create_functions.isEmpty() ||
                !create_procedures.isEmpty() ||
                !create_triggers.isEmpty();

        if (plsql)
            out.append("SET TERM ^ ;\n\n");

        for (Create_function_bodyContext create_function : create_functions)
            out.append(getRewriterText(create_function)).append("\n\n");

        for (Create_procedure_bodyContext create_procedure : create_procedures)
            out.append(getRewriterText(create_procedure)).append("\n\n");

        for (Create_triggerContext create_trigger : create_triggers)
            out.append(getRewriterText(create_trigger)).append("\n\n");

        if (plsql)
            out.append("SET TERM ; ^\n\n");

        for (Alter_triggerContext alter_trigger : alter_triggers)
            out.append(getRewriterText(alter_trigger)).append("\n\n");

        return out.toString();
    }

    void insertBefore(ParserRuleContext ctx, Object text) {
        if (ctx != null)
            rewriter.insertBefore(ctx.start, text);
    }

    void insertBefore(TerminalNode term, Object text) {
        if (term != null)
            rewriter.insertBefore(term.getSymbol(), text);
    }

    void insertAfter(ParserRuleContext ctx, Object text) {
        if (ctx != null)
            rewriter.insertAfter(ctx.stop, text);
    }

    void insertAfter(TerminalNode term, Object text) {
        if (term != null)
            rewriter.insertAfter(term.getSymbol(), text);
    }

    void replace(ParserRuleContext ctx, Object text) {
        if (ctx != null)
            rewriter.replace(ctx.start, ctx.stop, text);
        sisoutRewriter();
    }

    void replace(TerminalNode term, Object text) {
        if (term != null)
            rewriter.replace(term.getSymbol(), text);
        sisoutRewriter();
    }

    void delete(ParserRuleContext ctx) {
        if (ctx != null)
            rewriter.delete(ctx.start, ctx.stop);
        sisoutRewriter();
    }

    void delete(TerminalNode term) {
        if (term != null)
            rewriter.delete(term.getSymbol());
        sisoutRewriter();
    }

    void delete(List<? extends ParserRuleContext> ctx_list) {
        if (ctx_list.size() != 0)
            rewriter.delete(ctx_list.get(0).start, ctx_list.get(ctx_list.size() - 1).stop);
        sisoutRewriter();
    }

    void sisoutRewriter() {

//        System.out.println("\n==========================================");
//        System.out.println(rewriter.getText());
//        System.out.println("==========================================\n");

    }


    void commentBlock(int start_tok_idx, int stop_tok_idx) {
        rewriter.insertBefore(start_tok_idx, "/*");
        rewriter.insertAfter(stop_tok_idx, "*/");

        List<Token> multi_line_comments = tokens.getTokens(start_tok_idx, stop_tok_idx, PlSqlLexer.MULTI_LINE_COMMENT);

        if (multi_line_comments != null)
            for (Token tok : multi_line_comments)
                rewriter.delete(tok);
    }

    String getIndentation(ParserRuleContext ctx) {
        Integer tok_idx = ctx.start.getTokenIndex();

        if (tok_idx > 0) {
            List<Token> spc_tok_list = tokens.getTokens(tok_idx - 1, tok_idx, PlSqlLexer.SPACES);

            if (spc_tok_list != null) {
                String spc = spc_tok_list.get(0).getText();
                Integer idx1 = spc.lastIndexOf('\r');
                Integer idx2 = spc.lastIndexOf('\n');
                return spc.substring((idx1 > idx2 ? idx1 : idx2) + 1);
            }
        }

        return "";
    }

    String getRuleText(RuleContext ctx) {
        return tokens.getText(ctx);
    }

    String getRewriterText(ParserRuleContext ctx) {
        return rewriter.getText(ctx.getSourceInterval());
    }

    void pushScope() {
        if (current_plsql_block == null)
            current_plsql_block = new PLSQLBlock();
        else
            current_plsql_block.pushScope();
    }

    void popScope() {
        if (current_plsql_block.scopes.size() == 1)
            current_plsql_block = null;
        else
            current_plsql_block.popScope();
    }

    @Override
    public void exitRelational_table(PlSqlParser.Relational_tableContext ctx) {
        delete(ctx.column_properties());
        delete(ctx.physical_properties());
    }

    @Override
    public void exitCreate_table(Create_tableContext ctx) {

        String table_name = null;
        if (ctx.tableview_name().id_expression() != null) {
            delete(ctx.tableview_name().PERIOD(0));
            delete(ctx.tableview_name().identifier());
            table_name = Ora2rdb.getRealName(getRuleText(ctx.tableview_name().id_expression()));
        }
        else
            table_name = Ora2rdb.getRealName(getRuleText(ctx.tableview_name().identifier()));



        if (Ora2rdb.table_not_null_cols.containsKey(table_name)) {
            TreeSet<String> columns_set = Ora2rdb.table_not_null_cols.get(table_name);


            if (ctx.relational_table() != null) {
                Relational_tableContext relational_tableContext = ctx.relational_table();

                for (Relational_propertyContext rel_prop_ctx : relational_tableContext.relational_property()) {

                    Column_definitionContext col_def_ctx = rel_prop_ctx.column_definition();

                    if (col_def_ctx != null) {
                        String column_name = Ora2rdb.getRealName(getRuleText(col_def_ctx.column_name()));

                        if (columns_set.contains(column_name)) {
                            boolean not_null = false;

                            for (Inline_constraintContext inl_con_ctx : col_def_ctx.inline_constraint()) {
                                if (inl_con_ctx.NOT() != null) {
                                    not_null = true;
                                    break;
                                }
                            }

                            if (!not_null)
                                insertAfter(col_def_ctx, " NOT NULL");
                        }
                    }
                }
            }
        }

        tables.add(ctx);
    }

    @Override
    public void exitColumn_definition(Column_definitionContext ctx) {
        if (ctx != null) {
            if (ctx.datatype() != null)
                if (ctx.datatype().native_datatype_element() != null)
                    if (ctx.datatype().native_datatype_element().RAW() != null) {
                        replace(ctx, ctx.column_name().getText() + " BLOB ");
                    }
        }
    }

    @Override
    public void exitDatatype(DatatypeContext ctx) {
        if (ctx.native_datatype_element() != null) {
            if (ctx.native_datatype_element().NUMBER() != null) {
                if (ctx.precision_part() != null)
                    replace(ctx.precision_part().ASTERISK(), "18");
                else
                    replace(ctx, getRewriterText(ctx) + "(18, 4)");
            } else if (ctx.native_datatype_element().FLOAT() != null) {
                if (ctx.precision_part() != null)
                    replace(ctx, "DOUBLE PRECISION");
            } else if (ctx.native_datatype_element().TIMESTAMP() != null) {
                delete(ctx.precision_part());
            } else if (ctx.native_datatype_element().VARCHAR2() != null ||
                    ctx.native_datatype_element().VARCHAR() != null) {
                if (ctx.precision_part() == null)
                    replace(ctx, getRewriterText(ctx) + "(250)");
            } else if (ctx.native_datatype_element().NUMERIC() != null) {
                if (ctx.precision_part() == null)
                    replace(ctx,getRewriterText(ctx) + "(18, 4)");
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
            replace(ctx, "BLOB SUB_TYPE TEXT");
        else if (ctx.NUMBER() != null)
            replace(ctx, "NUMERIC");
        else if (ctx.BINARY_FLOAT() != null)
            replace(ctx, "FLOAT");
        else if (ctx.BINARY_DOUBLE() != null)
            replace(ctx, "DOUBLE PRECISION");
        else if (ctx.NCHAR() != null)
            replace(ctx, "CHAR");
        else if (ctx.BINARY_INTEGER() != null)
            replace(ctx, "INTEGER");
    }

    @Override
    public void exitComment_on_column(Comment_on_columnContext ctx) {
        if (ctx.column_name() != null) {
            Column_nameContext column_nameContext = ctx.column_name();
            if (column_nameContext.identifier() != null) {
                delete(column_nameContext.identifier());
                delete(column_nameContext.PERIOD(0));
            }
        }
    }

    @Override
    public void exitTableview_name(Tableview_nameContext ctx) {
        if (ctx.id_expression() != null) {
            delete(ctx.identifier());

            if (ctx.PERIOD().size() > 0)
                delete(ctx.PERIOD(0));

        }
    }

    @Override
    public void exitOut_of_line_constraint(Out_of_line_constraintContext ctx) {
        delete(ctx.constraint_state());
    }

    @Override
    public void exitAlter_table(Alter_tableContext ctx) {

        if (ctx.tableview_name().PERIOD() != null) {
            delete(ctx.tableview_name().PERIOD(0));
            delete(ctx.tableview_name().identifier());
        }
        Constraint_clausesContext constraint_clauses_ctx = ctx.constraint_clauses();
        Column_clausesContext column_clauses_ctx = ctx.column_clauses();

        if (constraint_clauses_ctx != null) {
            if (constraint_clauses_ctx.out_of_line_constraint().size() != 0) {
                Constraint_stateContext constraint_state_ctx = constraint_clauses_ctx.out_of_line_constraint(0).constraint_state();
                delete(constraint_state_ctx);
            }
        } else if (column_clauses_ctx != null) {

            Add_modify_drop_column_clausesContext add_modify_drop_column_clausesContext = column_clauses_ctx.add_modify_drop_column_clauses();
            if (add_modify_drop_column_clausesContext != null) {
                Modify_column_clausesContext modify_column_clauses_ctx = add_modify_drop_column_clausesContext.modify_column_clauses(0);

                if (modify_column_clauses_ctx.modify_col_properties().size() != 0) {
                    Modify_col_propertiesContext modify_col_properties_ctx = modify_column_clauses_ctx.modify_col_properties(0);

                    if (modify_col_properties_ctx.inline_constraint().size() != 0) {
                        if (modify_col_properties_ctx.inline_constraint(0).NULL_() != null) {
                            delete(ctx);
                            return;
                        }
                    }
                }
            }
        }

        alter_tables.add(ctx);
    }


    @Override
    public void exitString_function(String_functionContext ctx) {
        if (ctx.SUBSTR() != null) {
            replace(ctx.SUBSTR(), "SUBSTRING");
            replace(ctx.COMMA(0), " FROM ");
            if (ctx.COMMA(1) != null)
                replace(ctx.COMMA(1), " FOR ");

        }
    }

    @Override
    public void exitGeneral_element_part(General_element_partContext ctx) {

        if (ctx.id_expression().size() == 1) {
            Id_expressionContext id_expr_ctx = ctx.id_expression(0);

            if (id_expr_ctx.regular_id().non_reserved_keywords_pre12c() != null) {

                if (id_expr_ctx.regular_id().non_reserved_keywords_pre12c().TO_NUMBER() != null) {
                    replace(id_expr_ctx.regular_id().non_reserved_keywords_pre12c().TO_NUMBER(), "CAST");
                    delete(ctx.function_argument().RIGHT_PAREN());
                    insertAfter(ctx.function_argument(), " AS NUMERIC)");
                }

                if (id_expr_ctx.regular_id().non_reserved_keywords_pre12c().TO_DATE() != null) {
                    replace(id_expr_ctx.regular_id().non_reserved_keywords_pre12c().TO_DATE(), "CAST");
                    delete(ctx.function_argument().RIGHT_PAREN());
                    insertAfter(ctx.function_argument(), " AS TIMESTAMP)");

                    if (ctx.function_argument().argument().size() > 1) {
                        for (int i = 1; i < ctx.function_argument().argument().size(); i++) {
                            delete(ctx.function_argument().COMMA(i - 1));
                            delete(ctx.function_argument().argument(i));
                        }
                    }
                }

                if (id_expr_ctx.regular_id().non_reserved_keywords_pre12c().INSTR() != null) {
                    replace(id_expr_ctx.regular_id().non_reserved_keywords_pre12c().INSTR(), "POSITION");
                    String tempArgument = ctx.function_argument().argument(0).getText();
                    replace(ctx.function_argument().argument(0), ctx.function_argument().argument(1).getText());
                    replace(ctx.function_argument().argument(1), tempArgument);
                }
            }
        }

        if (ctx.id_expression().size() > 1) {
            for (Id_expressionContext id_expr_ctx : ctx.id_expression()) {
                String id = getRewriterText(id_expr_ctx);

                if (id.startsWith(":"))
                    replace(id_expr_ctx, id.substring(1));
            }
        } else {
            String name = Ora2rdb.getRealName(getRuleText(ctx.id_expression(0)));

            if (current_plsql_block != null && current_plsql_block.array_to_table.containsKey(name) &&
                    ctx.function_argument() != null) {
                String select_stmt = "(SELECT VAL FROM " + current_plsql_block.array_to_table.get(name) + " WHERE ";
                boolean abort = false;

                if (ctx.function_argument().argument().size() == 1) {

                    select_stmt += "I" + 1 + " = " + getRewriterText(ctx.function_argument().argument(0));
                } else {
                    abort = true;
                }


                if (!abort) {
                    select_stmt += ")";
                    replace(ctx, select_stmt);
                    return;
                }
            }

            Regular_idContext regular_id_ctx = ctx.id_expression(0).regular_id();

            if (regular_id_ctx != null) {
                if (regular_id_ctx.non_reserved_keywords_pre12c() != null) {
                    if (regular_id_ctx.non_reserved_keywords_pre12c().REPLACE() != null) {
                        if (ctx.function_argument() != null) {
                            Function_argumentContext function_argument_ctx = ctx.function_argument();

                            if (function_argument_ctx != null)
                                if (function_argument_ctx.argument().size() == 2)
                                    insertAfter(function_argument_ctx.argument(1), ", ''");
                        }
                    }
                    replace(regular_id_ctx.non_reserved_keywords_pre12c().LENGTH(), "CHAR_LENGTH");
                }
            }
        }
        convertFunctionCall(ctx);
    }

    private  void convertProcedureWithOutParameters(Function_callContext ctx){
        String functionCallName;
        if (ctx.routine_name().id_expression().size() >= 1)
            functionCallName = Ora2rdb.getRealName(getRuleText(ctx.routine_name().id_expression(0)));
        else
            functionCallName = Ora2rdb.getRealName(getRuleText(ctx.routine_name().identifier()));

        TreeSet<String> parameter_set = null;
        if(Ora2rdb.procedures_with_out_parameters.containsKey(parent_procedure_name)&&
                Ora2rdb.procedures_with_out_parameters.get(parent_procedure_name).containsKey(functionCallName)) {
            parameter_set = new TreeSet<>(
                    Ora2rdb.procedures_with_out_parameters.get(parent_procedure_name).get(functionCallName).keySet());
            StringBuilder return_parameters = new StringBuilder();
        }else if(Ora2rdb.out_parameters_in_procedure.containsKey(functionCallName)) {
            parameter_set = new TreeSet<>(
                    Ora2rdb.out_parameters_in_procedure.get(functionCallName).keySet());
        }
        TreeMap<String, Integer> parameter_numbers = Ora2rdb.out_parameters_in_procedure.get(functionCallName);
        StringBuilder selectQuery = new StringBuilder();

        selectQuery.append("SELECT ");
        for (String parameter: parameter_set){
            if (parameter.equals(parameter_set.last()))
                selectQuery.append(parameter).append("_OUT ");
            else
                selectQuery.append(parameter).append("_OUT, ");
        }
        selectQuery.append(" FROM ");
        insertBefore(ctx.routine_name(),selectQuery);
        selectQuery = new StringBuilder(" INTO ");
        for (String parameter: parameter_set){
            if (parameter.equals(parameter_set.last()))
                selectQuery.append(parameter);
            else
                selectQuery.append(parameter).append(", ");
        }
        insertAfter(ctx.function_argument(), selectQuery);
    }
    private  void convertFunctionWithOutParameters(Function_callContext ctx){
        String functionCallName;
        if (ctx.routine_name().id_expression().size() >= 1)
            functionCallName = Ora2rdb.getRealName(getRuleText(ctx.routine_name().id_expression(0)));
        else
            functionCallName = Ora2rdb.getRealName(getRuleText(ctx.routine_name().identifier()));

        current_plsql_block.procedure_names_with_out_parameters.add(functionCallName);
        TreeMap<String, Integer> parameter_numbers = Ora2rdb.out_parameters_in_function.get(functionCallName);
        TreeSet<String> parameter_set = null;
        if(Ora2rdb.functions_with_out_parameters.containsKey(parent_procedure_name)&&
                Ora2rdb.functions_with_out_parameters.get(parent_procedure_name).containsKey(functionCallName)) {
            parameter_set = new TreeSet<>(
                    Ora2rdb.functions_with_out_parameters.get(parent_procedure_name).get(functionCallName).keySet());
            StringBuilder return_parameters = new StringBuilder();
        }else if(Ora2rdb.out_parameters_in_function.containsKey(functionCallName)) {
            parameter_set = new TreeSet<>(
                    Ora2rdb.out_parameters_in_function.get(functionCallName).keySet());
        }
        StringBuilder selectQuery = new StringBuilder();


        selectQuery.append("SELECT ").append("RET_VAL, ");
        for (String parameter : parameter_set) {
            if (parameter.equals(parameter_set.last()))
                selectQuery.append(parameter).append("_OUT ");
            else
                selectQuery.append(parameter).append("_OUT, ");
        }
        selectQuery.append(" FROM ").append(getRewriterText(ctx));
        String functionRetValName = functionCallName.toUpperCase().concat("_RET_VAL");
        selectQuery.append(" INTO ").append(functionRetValName).append(", ");
        for (String parameter : parameter_set) {
            if (parameter.equals(parameter_set.last()))
                selectQuery.append(ctx.function_argument().argument(parameter_numbers.get(parameter)).getText()).append('\n');
            else
                selectQuery.append(ctx.function_argument().argument(parameter_numbers.get(parameter)).getText()).append(", ");
        }

        current_plsql_block.qwery_call_function_with_out_parameters = selectQuery.toString();
        replace(ctx, functionRetValName);
        if (current_plsql_block.getStatement().loop_statement() != null)
            return;
        if(current_plsql_block.getStatement() != null) {
            insertBefore(current_plsql_block.getStatement(), current_plsql_block.qwery_call_function_with_out_parameters);
            current_plsql_block.clearStatement();
        }
    }
    public boolean containsOutParametersInProcedure(String functinName){
        if (parent_procedure_name != null && Ora2rdb.procedures_with_out_parameters.containsKey(parent_procedure_name)
                && Ora2rdb.procedures_with_out_parameters.get(parent_procedure_name).containsKey(functinName)
                || Ora2rdb.out_parameters_in_procedure.containsKey(functinName))
            return true;
        return false;
    }
    public boolean containsOutParametersInFunction(String functinName){
        if (parent_procedure_name != null && Ora2rdb.functions_with_out_parameters.containsKey(parent_procedure_name)
                && Ora2rdb.functions_with_out_parameters.get(parent_procedure_name).containsKey(functinName)
                || Ora2rdb.out_parameters_in_function.containsKey(functinName))
            return true;
        return false;
    }
    private void convertFunctionCall(Function_callContext ctx) {
        String functionCallName;
        if (ctx.routine_name().id_expression().size() >= 1)
            functionCallName = Ora2rdb.getRealName(getRuleText(ctx.routine_name().id_expression(0)));
        else
            functionCallName = Ora2rdb.getRealName(getRuleText(ctx.routine_name().identifier()));

//        boolean procedurWithOutParameters = containsOutParametersInProcedure(functionCallName);
        if(containsOutParametersInProcedure(functionCallName)){
            convertProcedureWithOutParameters(ctx);
        }
        else if (Ora2rdb.out_parameters_in_function.containsKey(functionCallName)) {
            convertFunctionWithOutParameters(ctx);
        }
        else {
            if (Ora2rdb.procedures_names.contains(functionCallName))
                replace(ctx, "EXECUTE PROCEDURE " + getRewriterText(ctx));
        }

    }

    private void convertFunctionCall(General_element_partContext ctx) {
        String functionCallName;
        if (ctx.id_expression().size() > 1)
            functionCallName = Ora2rdb.getRealName(getRuleText(ctx.id_expression(1)));
        else
            functionCallName = Ora2rdb.getRealName(getRuleText(ctx.id_expression(0)));


        if (Ora2rdb.out_parameters_in_function.containsKey(functionCallName)) {
            current_plsql_block.procedure_names_with_out_parameters.add(functionCallName);
            TreeMap<String, Integer> parameter_numbers = Ora2rdb.out_parameters_in_function.get(functionCallName);
            TreeSet<String> parameter_set = new TreeSet<>(Ora2rdb.out_parameters_in_function.
                    get(functionCallName).keySet());

            StringBuilder selectQuery = new StringBuilder();
            selectQuery.append("SELECT ").append("RET_VAL, ");
            for (String parameter : parameter_set) {
                if (parameter.equals(parameter_set.last()))
                    selectQuery.append(parameter).append("_OUT ");
                else
                    selectQuery.append(parameter).append("_OUT, ");
            }
            selectQuery.append(" FROM ").append(getRewriterText(ctx));
            String functionRetValName = functionCallName.toUpperCase().concat("_RET_VAL");
            selectQuery.append(" INTO ").append(functionRetValName).append(", ");
            for (String parameter : parameter_set) {
                if (parameter.equals(parameter_set.last()))

                    selectQuery.append(ctx.function_argument().argument(parameter_numbers.get(parameter)).getText()).append('\n');
                else
                    selectQuery.append(ctx.function_argument().argument(parameter_numbers.get(parameter)).getText()).append(", ");
            }
            current_plsql_block.qwery_call_function_with_out_parameters = selectQuery.toString();
            replace(ctx, functionRetValName);

            if(current_plsql_block.getStatement() != null) {
                if (current_plsql_block.getStatement().loop_statement() != null) {
                    Loop_statementContext loop = current_plsql_block.getStatement().loop_statement();
                    StringBuilder stringBuilder = new StringBuilder();
                    stringBuilder.
                            append(selectQuery.toString()).
                            append("if(:").append(functionRetValName).append(")\n").
                            append("break;\n");

                    replace(loop.condition(), "TRUE");
                    insertBefore(loop.seq_of_statements(), stringBuilder.toString());
                }
                else {
                    insertBefore(current_plsql_block.getStatement(), current_plsql_block.qwery_call_function_with_out_parameters);
                    current_plsql_block.clearStatement();

                }
            }
        }

    }

    @Override
    public void exitVariable_name(Variable_nameContext ctx) {
        if (ctx.id_expression().size() > 1) {
            for (Id_expressionContext id_expr_ctx : ctx.id_expression()) {
                String id = getRewriterText(id_expr_ctx);

                if (id.startsWith(":"))
                    replace(id_expr_ctx, id.substring(1));
            }
        }
    }

    @Override
    public void exitReferences_clause(References_clauseContext ctx) {
        if (ctx.tableview_name().PERIOD() != null) {
            delete(ctx.tableview_name().identifier());
            delete(ctx.tableview_name().PERIOD(0));
        }
    }

    @Override
    public void exitCreate_index(Create_indexContext ctx) {
        String index_name = Ora2rdb.getRealName(getRuleText(ctx.index_name().id_expression()));

        if (Ora2rdb.index_names.contains(index_name)) {
            delete(ctx);
            return;
        }

        Table_index_clauseContext table_index_clause_ctx = ctx.table_index_clause();

        for (Index_exprContext index_expr_ctx : table_index_clause_ctx.index_expr()) {
            if (index_expr_ctx.expression() != null) {
                delete(ctx);
                return;
            }
        }


        delete(ctx.index_name().identifier());
        delete(ctx.index_name().PERIOD());


        if (table_index_clause_ctx.tableview_name().PERIOD() != null) {
            delete(table_index_clause_ctx.tableview_name().identifier());
            delete(table_index_clause_ctx.tableview_name().PERIOD(0));
        }
        delete(table_index_clause_ctx.index_properties());

        create_indexes.add(ctx);
    }

    @Override
    public void exitCreate_sequence(Create_sequenceContext ctx) {
        Sequence_nameContext sequence_name_ctx = ctx.sequence_name();

        if (sequence_name_ctx.PERIOD() != null) {
            delete(sequence_name_ctx.id_expression(0));
            delete(sequence_name_ctx.PERIOD(0));
        }

        for (Sequence_specContext sequence_spec_ctx : ctx.sequence_spec())
            delete(sequence_spec_ctx);

        String set_generator_statements = "";

        for (Sequence_start_clauseContext sequence_start_clause_ctx : ctx.sequence_start_clause()) {
            set_generator_statements += "\nALTER SEQUENCE " + getRuleText(sequence_name_ctx.id_expression(1)) +
                    " RESTART WITH " + sequence_start_clause_ctx.UNSIGNED_INTEGER().getText() + ";";

            delete(sequence_start_clause_ctx);
        }

        replace(ctx, getRewriterText(ctx) + set_generator_statements);

        sequences.add(ctx);
    }

    @Override
    public void enterCreate_view(Create_viewContext ctx) {
        current_view = Ora2rdb.views.get(Ora2rdb.getRealName(getRuleText(ctx.id_expression(0))));
    }

    @Override
    public void exitCreate_view(Create_viewContext ctx) {
        replace(ctx.REPLACE(), "ALTER");
        delete(ctx.FORCE());
        if (ctx.PERIOD() != null) {
            delete(ctx.schema_name());
            delete(ctx.PERIOD());
        }
        current_view = null;
    }

    @Override
    public void exitDml_table_expression_clause(Dml_table_expression_clauseContext ctx) {
        if (current_view != null && ctx.tableview_name() != null) {
            String dependency_name = Ora2rdb.getRealName(getRuleText(ctx.tableview_name()));

            if (Ora2rdb.views.containsKey(dependency_name))
                current_view.dependencies.add(Ora2rdb.views.get(dependency_name));
        }
    }

    @Override
    public void exitSubquery_restriction_clause(Subquery_restriction_clauseContext ctx) {
        delete(ctx);
    }

    @Override
    public void exitComment_on_table(Comment_on_tableContext ctx) {
        comments.add(ctx);
    }

    @Override
    public void exitQuery_block(Query_blockContext ctx) {
        if (ctx.into_clause() != null) {
            String into_clause = getRewriterText(ctx.into_clause());
            delete(ctx.into_clause());
            replace(ctx, getRewriterText(ctx) + " " + into_clause);
        }
    }

    @Override
    public void exitRegular_id(Regular_idContext ctx) {
        if(ctx.non_reserved_keywords_pre12c() != null) {
            switch (getRuleText(ctx.non_reserved_keywords_pre12c()).toUpperCase()) {
                case "SYSTIMESTAMP":
                    replace(ctx, "CURRENT_TIMESTAMP");
                    break;
                case "SYSDATE":
                    replace(ctx, "CURRENT_TIMESTAMP");
            }
        }
    }

    @Override
    public void exitFunction_name(Function_nameContext ctx) {
        if (ctx.id_expression() != null) {
            delete(ctx.identifier());
            delete(ctx.PERIOD());
        }
    }

    @Override
    public void enterCreate_function_body(Create_function_bodyContext ctx) {
        pushScope();
        String procedureName;
        if (ctx.function_name().id_expression() != null)
            procedureName = Ora2rdb.getRealName(ctx.function_name().id_expression().getText());
        else
            procedureName = Ora2rdb.getRealName(ctx.function_name().identifier().id_expression().getText());
        if (ctx.function_name().id_expression() != null)
            current_plsql_block.procedure_name = procedureName;
        else
            current_plsql_block.procedure_name = procedureName;

        parent_procedure_name = procedureName;
    }

    @Override
    public void exitCreate_function_body(Create_function_bodyContext ctx) {
        replace(ctx.REPLACE(), "ALTER");
        replace(ctx.IS(), "AS");
        replace(ctx.SEMICOLON(), "^");

        String functionName;
        if (ctx.function_name().id_expression() != null)
            functionName = Ora2rdb.getRealName(ctx.function_name().id_expression().getText());
         else
            functionName = Ora2rdb.getRealName(ctx.function_name().identifier().id_expression().getText());

        if (Ora2rdb.out_parameters_in_function.containsKey(functionName)) {

            TreeSet<String> parameter_set = new TreeSet<>(Ora2rdb.out_parameters_in_function.
                    get(functionName).keySet());
            replace(ctx.FUNCTION(), "PROCEDURE");
            replace(ctx.RETURN(), "RETURNS (RET_VAL");
            StringBuilder return_parameters = new StringBuilder();
            return_parameters.append(", ");
            for(String parameter_name : parameter_set ) {
                String type_spec = "";
                for (ParameterContext parameter : ctx.parameter()) {
                    String parameter_ = Ora2rdb.getRealName(parameter.parameter_name().getText());
                    if (parameter_.equals(parameter_name)) {
                        type_spec = getRewriterText(parameter.type_spec());
                        break;
                    }
                }
                if (parameter_name.equals(parameter_set.last()))
                    return_parameters.append(parameter_name).append("_OUT ").append(type_spec).append(")\n");
                else
                    return_parameters.append(parameter_name).append("_OUT ").append(type_spec).append(", \n");
            }
            insertAfter(ctx.type_spec(), return_parameters + " )");

        } else {
            replace(ctx.RETURN(), "RETURNS");
        }

        if (current_plsql_block.procedure_names_with_out_parameters.size() > 0) {
            StringBuilder declare_ret_val = new StringBuilder();
            for (String procedureName : current_plsql_block.procedure_names_with_out_parameters) {
                declare_ret_val.append("\nDECLARE ").
                        append(procedureName).
                        append("_RET_VAL ").
                        append(Ora2rdb.function_returns_type.get(procedureName)).
                        append(";");
            }

            insertAfter(ctx.seq_of_declare_specs(), declare_ret_val);
        }

        autonomousTransactionBlockConvert(ctx);


        StringBuilder temp_tables_ddl = new StringBuilder();

        for (String table_ddl : current_plsql_block.temporary_tables_ddl)
            temp_tables_ddl.append(table_ddl).append("\n\n");

        if (!Ora2rdb.reorder)
            replace(ctx, temp_tables_ddl + "SET TERM ^ ;\n\n" + getRewriterText(ctx) + "\n\nSET TERM ; ^");
        else
            create_temporary_tables.add(temp_tables_ddl.toString());

        popScope();
        create_functions.add(ctx);
        parent_procedure_name = null;
    }

    @Override
    public void enterFunction_body(PlSqlParser.Function_bodyContext ctx) {
        pushScope();
        current_plsql_block.procedure_name = Ora2rdb.getRealName(ctx.identifier().getText());
        if(parent_procedure_name == null){
            parent_procedure_name = Ora2rdb.getRealName(ctx.identifier().getText());
        }
    }

    @Override
    public void exitFunction_body(Function_bodyContext ctx) { //todo declare variable не добавлена в процедуру (цикл for n in 1..value не будет работать в процедуре)
        replace(ctx.IS(), "AS");
        replace(ctx.SEMICOLON(), "^");
        for(ParameterContext parameter : ctx.parameter())
            if(getRewriterText(parameter).startsWith(":"))
                replace(parameter, getRewriterText(parameter).substring(1));


        String functionName = Ora2rdb.getRealName(ctx.identifier().getText());

        TreeSet<String> parameter_set = null;
        if(Ora2rdb.functions_with_out_parameters.containsKey(parent_procedure_name)&&
                Ora2rdb.functions_with_out_parameters.get(parent_procedure_name).containsKey(functionName)) {
            parameter_set = new TreeSet<>(
                    Ora2rdb.functions_with_out_parameters.get(parent_procedure_name).get(functionName).keySet());
            StringBuilder return_parameters = new StringBuilder();

            if (current_plsql_block.procedure_names_with_out_parameters.size() > 0) {
                StringBuilder declare_ret_val = new StringBuilder();
                TreeMap<String, String> func = new TreeMap<>();
                func = Ora2rdb.function_returns_type_with_parent.get(parent_procedure_name);
                for (String procedureName : current_plsql_block.procedure_names_with_out_parameters) {
                    declare_ret_val.append("\nDECLARE ").
                            append(procedureName).
                            append("_RET_VAL ").
                            append(func.get(procedureName)).
                            append(";");
                }

                insertAfter(ctx.seq_of_declare_specs(), declare_ret_val);
            }

        }else if(Ora2rdb.out_parameters_in_function.containsKey(functionName)) {
            parameter_set = new TreeSet<>(Ora2rdb.out_parameters_in_function.get(functionName).keySet());
            if (current_plsql_block.procedure_names_with_out_parameters.size() > 0) {
                StringBuilder declare_ret_val = new StringBuilder();
                for (String procedureName : current_plsql_block.procedure_names_with_out_parameters) {
                    declare_ret_val.append("\nDECLARE ").
                            append(procedureName).
                            append("_RET_VAL ").
                            append(Ora2rdb.function_returns_type.get(procedureName)).
                            append(";");
                }

                insertAfter(ctx.seq_of_declare_specs(), declare_ret_val);
            }
        }
        if(parameter_set != null){
//            Ora2rdb.function_returns_type.put(functionName, getRewriterText(ctx.type_spec()));
            replace(ctx.FUNCTION(), "PROCEDURE");
            replace(ctx.RETURN(), "RETURNS (RET_VAL");

                StringBuilder return_parameters = new StringBuilder();
                return_parameters.append(", ");
                for(String parameter_name : parameter_set ) {
                    String type_spec = "";
                    for (ParameterContext parameter : ctx.parameter()) {
                        String parameter_ = Ora2rdb.getRealName(parameter.parameter_name().getText());
                        if (parameter_.equals(parameter_name)) {
                            type_spec = getRewriterText(parameter.type_spec());
                            break;
                        }
                    }
                    if (parameter_name.equals(parameter_set.last()))
                        return_parameters.append(parameter_name).append("_OUT ").append(type_spec).append(")\n");
                    else
                        return_parameters.append(parameter_name).append("_OUT ").append(type_spec).append(", \n");
                }
            insertAfter(ctx.type_spec(), return_parameters + " )");
        } else {
            replace(ctx.RETURN(), "RETURNS");
        }
        delete(ctx.SEMICOLON());

        StringBuilder declare_loop_index_names = new StringBuilder();
        if(!loop_index_names.isEmpty()) {
            for (String index_name : loop_index_names) {
                declare_loop_index_names.append("\n DECLARE VARIABLE ").append(index_name).append(" INTEGER;");
            }
            insertAfter(ctx.seq_of_declare_specs(), declare_loop_index_names.toString());
        }
        loop_index_names.clear();

        autonomousTransactionBlockConvert(ctx);


        popScope();
        if(parent_procedure_name.equals(functionName))
            parent_procedure_name = null;

    }


    @Override
    public void exitFunction_spec(Function_specContext ctx) {
        replace(ctx.RETURN(), "RETURNS");
    }

    @Override
    public void exitParameter(ParameterContext ctx) {
        for (TerminalNode in_node : ctx.IN())
            delete(in_node);
        for (TerminalNode out_node : ctx.OUT())
            delete(out_node);
        for (TerminalNode nocopy_node : ctx.NOCOPY())
            delete(nocopy_node);
        for (TerminalNode inout_node : ctx.INOUT())
            delete(inout_node);

        if (current_plsql_block != null)
            current_plsql_block.declareVar(Ora2rdb.getRealName(getRuleText(ctx.parameter_name())));
    }

    @Override
    public void exitExecute_immediate(Execute_immediateContext ctx) {
        replace(ctx.IMMEDIATE(), "STATEMENT");
        insertBefore(ctx.expression(), "(");
        insertAfter(ctx.expression(), ")");
        if(ctx.into_clause() != null) {
            String into_clause = getRewriterText(ctx.into_clause());
            delete(ctx.into_clause());
            replace(ctx, getRewriterText(ctx) + " " + into_clause);

        }
    }

    @Override
    public void exitPragma_declaration(Pragma_declarationContext ctx) {
        delete(ctx);
    }

    @Override
    public void exitVariable_declaration(Variable_declarationContext ctx) {
        String name = Ora2rdb.getRealName(getRuleText(ctx.identifier()));
        String type = Ora2rdb.getRealName(getRuleText(ctx.type_spec()));

        if (current_plsql_block != null) {
            if (current_plsql_block.array_types.containsKey(type)) {
                current_plsql_block.declareArray(name, type);
                commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
                return;
            }

            current_plsql_block.declareVar(name);
        }

        insertBefore(ctx, "DECLARE ");
    }

    @Override
    public void exitType_declaration(Type_declarationContext ctx) {
        commentBlock(ctx.start.getTokenIndex(), ctx.stop.getTokenIndex());
        if (ctx.table_type_def() != null) {
            if (current_plsql_block != null && ctx.table_type_def().TABLE() != null && ctx.table_type_def().table_indexed_by_part() != null) {
                current_plsql_block.declareTypeOfArray(Ora2rdb.getRealName(getRuleText(ctx.identifier())),
                        getRewriterText(ctx.table_type_def().type_spec()),
                        getRewriterText(ctx.table_type_def().table_indexed_by_part().type_spec()));
            }
        }
    }

    @Override
    public void exitCursor_declaration(Cursor_declarationContext ctx) {
        replace(ctx.CURSOR(), "DECLARE");
        replace(ctx.IS(), "CURSOR FOR");
        insertBefore(ctx.select_statement(), "(");
        insertAfter(ctx.select_statement(), ")");
    }

    @Override
    public void exitId_expression(Id_expressionContext ctx) {
        if (current_plsql_block != null && current_plsql_block.containsInScope(Ora2rdb.getRealName(getRuleText(ctx)))) {
            replace(ctx, ":" + getRuleText(ctx));
        }
    }

    @Override
    public void exitBind_variable(Bind_variableContext ctx) {
        String var = getRuleText(ctx);
        String upper = var.toUpperCase();

        if (upper.startsWith(":OLD.") || upper.startsWith(":NEW."))
            replace(ctx, var.substring(1));
    }

    @Override
    public void exitColumn_name(Column_nameContext ctx) {
        try {
            String name = getRewriterText(ctx);

            if (name.startsWith(":"))
                replace(ctx, name.substring(1));
        } catch (Exception e) {
            System.err.println(e.fillInStackTrace() + rewriter.getText());
        }

    }

    @Override
    public void exitSql_plus_command_wrapper(PlSqlParser.Sql_plus_command_wrapperContext ctx) {
        delete(ctx);
    }

    @Override
    public void exitProcedure_name(Procedure_nameContext ctx) {
        if (ctx.id_expression() != null) {
            delete(ctx.identifier());
            delete(ctx.PERIOD());
        }
    }

    @Override
    public void exitCreate_package(PlSqlParser.Create_packageContext ctx) {
        if (ctx.REPLACE() != null) {
            replace(ctx.REPLACE(), "ALTER");
        }
        if (ctx.schema_object_name() != null) {
            delete(ctx.schema_object_name());
            delete(ctx.PERIOD());
        }
        if (ctx.AS() != null) {
            insertAfter(ctx.AS(), " BEGIN");
        }
        if (ctx.IS() != null) {
            replace(ctx.IS(), "AS");
            insertAfter(ctx.IS(), " BEGIN");
        }
        if (!ctx.package_name().isEmpty()) {
            if (ctx.package_name(ctx.package_name().size() - 1) != null) {
                delete(ctx.package_name(ctx.package_name().size() - 1));
            }
        }
    }

    @Override
    public void enterCreate_package_body(PlSqlParser.Create_package_bodyContext ctx) {
        pushScope();
    }

    @Override
    public void exitCreate_package_body(Create_package_bodyContext ctx) {
        if (ctx.OR() != null) {
            if (ctx.REPLACE() != null) {
                delete(ctx.OR());
                delete(ctx.REPLACE());
                replace(ctx.CREATE(), "RECREATE");
            }
        }
        if (ctx.schema_object_name() != null) {
            delete(ctx.schema_object_name());
            delete(ctx.PERIOD());
        }
        if (ctx.AS() != null) {
            insertAfter(ctx.AS(), " BEGIN");
        }
        if (ctx.IS() != null) {
            replace(ctx.IS(), "AS");
            insertAfter(ctx.IS(), " BEGIN");
        }
        if (!ctx.package_name().isEmpty()) {
            if (ctx.package_name(ctx.package_name().size() - 1) != null) {
                delete(ctx.package_name(ctx.package_name().size() - 1));
            }
        }

        StringBuilder temp_tables_ddl = new StringBuilder();
        for (String table_ddl : current_plsql_block.temporary_tables_ddl)
            temp_tables_ddl.append(table_ddl).append("\n\n");

        if (!Ora2rdb.reorder)
            replace(ctx, temp_tables_ddl + "SET TERM ^ ;\n\n" + getRewriterText(ctx) + "\n\nSET TERM ; ^");
        else
            create_temporary_tables.add(temp_tables_ddl.toString());
        popScope();
    }

    @Override
    public void enterCreate_procedure_body(Create_procedure_bodyContext ctx) {
        pushScope();
        String procedureName;
        if (ctx.procedure_name().id_expression() != null)
            procedureName = Ora2rdb.getRealName(ctx.procedure_name().id_expression().getText());
        else
            procedureName = Ora2rdb.getRealName(ctx.procedure_name().identifier().id_expression().getText());
        parent_procedure_name = procedureName;
    }

    @Override
    public void exitCreate_procedure_body(Create_procedure_bodyContext ctx) {
        replace(ctx.REPLACE(), "ALTER");
        replace(ctx.IS(), "AS");
        replace(ctx.SEMICOLON(), "^");




       String procedure_name = Ora2rdb.getRealName(ctx.procedure_name().identifier().id_expression().getText());

        if (Ora2rdb.out_parameters_in_procedure.containsKey(procedure_name)) {
            TreeSet<String> parameter_set = new TreeSet<>(Ora2rdb.out_parameters_in_procedure.
                    get(procedure_name).keySet());
            StringBuilder return_parameters = new StringBuilder();
            return_parameters.append("RETURNS( ");

            insertBefore(ctx.body().END(), "SUSPEND\n");
            for(String parameter_name : parameter_set ) {
                String type_spec = "";
                    for (ParameterContext parameter : ctx.parameter()) {
                        String parameter_ = Ora2rdb.getRealName(parameter.parameter_name().getText());
                        if (parameter_.equals(parameter_name)) {
//                            type_spec = Ora2rdb.getRealName(parameter.type_spec().getText());
                           type_spec = getRewriterText(parameter.type_spec());
                            break;
                        }
                    }
                insertBefore(ctx.body().END(), parameter_name + "_OUT = " + parameter_name + ";\n");
                if (parameter_name.equals(parameter_set.last()))
                    return_parameters.append(parameter_name).append("_OUT ").append(type_spec).append(")\n");
                else
                    return_parameters.append(parameter_name).append("_OUT ").append(type_spec).append(", \n");
            }
            insertBefore(ctx.IS(),  return_parameters.toString() + '\n');
        }

        if (current_plsql_block.procedure_names_with_out_parameters.size() > 0) {
            StringBuilder declare_ret_val = new StringBuilder();
            for (String procedureName : current_plsql_block.procedure_names_with_out_parameters) {
                declare_ret_val.append("\nDECLARE ").
                        append(procedureName).
                        append("_RET_VAL ").
                        append(Ora2rdb.function_returns_type.get(procedureName)).
                        append(";");
            }

            insertAfter(ctx.seq_of_declare_specs(), declare_ret_val);
        }

        autonomousTransactionBlockConvert(ctx);

        StringBuilder temp_tables_ddl = new StringBuilder();

        for (String table_ddl : current_plsql_block.temporary_tables_ddl)
            temp_tables_ddl.append(table_ddl).append("\n\n");

        if (!Ora2rdb.reorder)
            replace(ctx, temp_tables_ddl + "SET TERM ^ ;\n\n" + getRewriterText(ctx) + "\n\nSET TERM ; ^");
        else
            create_temporary_tables.add(temp_tables_ddl.toString());

        popScope();
        create_procedures.add(ctx);
        if (containsException & !exceptionExist) {
            String exception = "CREATE EXCEPTION CUSTOM_EXCEPTION 'error';";
            insertBefore(ctx, exception + "\n\n");
        }
        containsException = false;
        parent_procedure_name = null;
    }


    @Override
    public void enterProcedure_body(Procedure_bodyContext ctx) {
        pushScope();
        if(parent_procedure_name == null){
            parent_procedure_name = Ora2rdb.getRealName(ctx.identifier().getText());
        }

    }

    @Override
    public void exitProcedure_body(Procedure_bodyContext ctx) {
        replace(ctx.IS(), "AS");
        delete(ctx.SEMICOLON());

        for(ParameterContext parameter : ctx.parameter())
            if(getRewriterText(parameter).startsWith(":"))
                replace(parameter, getRewriterText(parameter).substring(1));


        String procedure_name = Ora2rdb.getRealName(ctx.identifier().id_expression().getText());
        TreeSet<String> parameter_set = null;
           if(Ora2rdb.procedures_with_out_parameters.containsKey(parent_procedure_name)&&
              Ora2rdb.procedures_with_out_parameters.get(parent_procedure_name).containsKey(procedure_name)) {
               parameter_set = new TreeSet<>(
                       Ora2rdb.procedures_with_out_parameters.get(parent_procedure_name).get(procedure_name).keySet());
               StringBuilder return_parameters = new StringBuilder();
           }else if(Ora2rdb.out_parameters_in_procedure.containsKey(procedure_name)) {
               parameter_set = new TreeSet<>(
                       Ora2rdb.out_parameters_in_procedure.get(procedure_name).keySet());
           }
           if(parameter_set != null){
            StringBuilder return_parameters = new StringBuilder();
            return_parameters.append("RETURNS( ");

            insertBefore(ctx.body().END(), "SUSPEND\n");
            for(String parameter_name : parameter_set ) {
                String type_spec = "";
                for (ParameterContext parameter : ctx.parameter()) {
                    String parameter_ = Ora2rdb.getRealName(parameter.parameter_name().getText());
                    if (parameter_.equals(parameter_name)) {
//                            type_spec = Ora2rdb.getRealName(parameter.type_spec().getText());
                        type_spec = getRewriterText(parameter.type_spec());
                        break;
                    }
                }

                insertBefore(ctx.body().END(), parameter_name + "_OUT = " + parameter_name + ";\n");
                if (parameter_name.equals(parameter_set.last()))
                    return_parameters.append(parameter_name).append("_OUT ").append(type_spec).append(")\n");
                else
                    return_parameters.append(parameter_name).append("_OUT ").append(type_spec).append(", \n");
            }
            insertBefore(ctx.IS(),  return_parameters.toString() + '\n');
        }
        autonomousTransactionBlockConvert(ctx);
        popScope();
        if(parent_procedure_name.equals(procedure_name))
            parent_procedure_name = null;
    }


    private void autonomousTransactionBlockConvert(Procedure_bodyContext ctx) {
        if (checkAndDeleteAutonomousTransaction(ctx.seq_of_declare_specs())) {
            insertBefore(ctx.body().seq_of_statements(), "IN AUTONOMOUS TRANSACTION DO BEGIN\n");
            insertAfter(ctx.body().seq_of_statements(), "\n\tEND");
        }
    }

    private void autonomousTransactionBlockConvert(Function_bodyContext ctx) {
        if (checkAndDeleteAutonomousTransaction(ctx.seq_of_declare_specs())) {
            insertBefore(ctx.body().seq_of_statements(), "IN AUTONOMOUS TRANSACTION DO BEGIN\n");
            insertAfter(ctx.body().seq_of_statements(), "\n\tEND");
        }
    }

    private void autonomousTransactionBlockConvert(Create_procedure_bodyContext ctx) {
        if (checkAndDeleteAutonomousTransaction(ctx.seq_of_declare_specs())) {
            insertBefore(ctx.body().seq_of_statements(), "IN AUTONOMOUS TRANSACTION DO BEGIN\n");
            insertAfter(ctx.body().seq_of_statements(), "\n\tEND");
        }
    }

    private void autonomousTransactionBlockConvert(Create_function_bodyContext ctx) {
        if (checkAndDeleteAutonomousTransaction(ctx.seq_of_declare_specs())) {
            insertBefore(ctx.body().seq_of_statements(), "IN AUTONOMOUS TRANSACTION DO BEGIN\n");
            insertAfter(ctx.body().seq_of_statements(), "\n\tEND");
        }
    }

    private boolean checkAndDeleteAutonomousTransaction(Seq_of_declare_specsContext ctx) {
        if (ctx != null) {
            if (ctx.declare_spec().size() > 0) {
                for (Declare_specContext declare_spec : ctx.declare_spec()) {
                    if (declare_spec.pragma_declaration() != null &&
                            declare_spec.pragma_declaration().AUTONOMOUS_TRANSACTION() != null) {
                        delete(declare_spec);
                        return true;
                    }
                }
            }
        }
        return false;
    }


    @Override
    public void exitType_spec(Type_specContext ctx) {
        if (ctx.PERCENT_TYPE() != null)
            replace(ctx, "TYPE OF COLUMN " + getRuleText(ctx.type_name()));
    }

    @Override
    public void exitTrigger_name(Trigger_nameContext ctx) {
        delete(ctx.identifier());
        delete(ctx.PERIOD());
    }

    @Override
    public void enterCreate_trigger(Create_triggerContext ctx) {
        pushScope();
    }

    @Override
    public void exitCreate_trigger(Create_triggerContext ctx) {
        replace(ctx.REPLACE(), "ALTER");
        insertBefore(ctx.trigger_body(), "AS\n");
        replace(ctx.SEMICOLON(), "^");

        StringBuilder temp_tables_ddl = new StringBuilder();

        for (String table_ddl : current_plsql_block.temporary_tables_ddl)
            temp_tables_ddl.append(table_ddl).append("\n\n");

        if (!Ora2rdb.reorder)
            replace(ctx, temp_tables_ddl + "SET TERM ^ ;\n\n" + getRewriterText(ctx) + "\n\nSET TERM ; ^");
        else
            create_temporary_tables.add(temp_tables_ddl.toString());

        popScope();
        create_triggers.add(ctx);
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
        if (current_plsql_block != null)
            current_plsql_block.trigger_when_condition = getRewriterText(ctx.condition());

        delete(ctx);
    }

    @Override
    public void exitDml_event_element(Dml_event_elementContext ctx) {
        if (current_plsql_block != null) {
            if (ctx.column_list() != null) {
                for (Column_nameContext col_name_ctx : ctx.column_list().column_name())
                    current_plsql_block.trigger_fields.add(getRuleText(col_name_ctx));
            }
        }

        delete(ctx.OF());
        if (ctx.column_list() != null) {
            delete(ctx.column_list().column_name());
        }
    }

    @Override
    public void enterBlock(BlockContext ctx) {
        pushScope();
    }

    @Override
    public void exitBlock(BlockContext ctx) {
        popScope();
    }

    @Override
    public void exitBody(BodyContext ctx) {
        if (current_plsql_block != null &&
                (current_plsql_block.trigger_fields.size() > 0 || current_plsql_block.trigger_when_condition != null)) {
            String execute_condition = "\nIF (";
            String update_condition = "";

            for (int i = 0; i < current_plsql_block.trigger_fields.size(); i++) {
                if (i != 0)
                    update_condition += " OR ";

                update_condition += "NEW." + current_plsql_block.trigger_fields.get(i) + " <> OLD." + current_plsql_block.trigger_fields.get(i);
            }

            if (current_plsql_block.trigger_fields.size() > 0 && current_plsql_block.trigger_when_condition != null)
                execute_condition += "(" + update_condition + ") AND (" + current_plsql_block.trigger_when_condition + ")";
            else if (current_plsql_block.trigger_fields.size() > 0)
                execute_condition += update_condition;
            else
                execute_condition += current_plsql_block.trigger_when_condition;

            execute_condition += ") THEN";

            if (ctx.seq_of_statements().statement().size() > 1)
                execute_condition += "\nBEGIN";

            insertAfter(ctx.BEGIN(), execute_condition);

            if (ctx.seq_of_statements().statement().size() > 1)
                insertBefore(ctx.END(), "END\n");
        }
    }

    @Override
    public void exitTrigger_block(Trigger_blockContext ctx) {
        delete(ctx.DECLARE());
    }

    @Override
    public void exitAlter_trigger(Alter_triggerContext ctx) {
        replace(ctx.ENABLE(), "ACTIVE");
        replace(ctx.DISABLE(), "INACTIVE");

        alter_triggers.add(ctx);
    }

    @Override
    public void exitLabel_name(Label_nameContext ctx) {
        delete(ctx);
    }

    @Override
    public void exitFunction_call(Function_callContext ctx) {
        convertFunctionCall(ctx);

        if (Ora2rdb.getRealName(getRuleText(ctx.routine_name())).equals("RAISE_APPLICATION_ERROR")) {
            containsException = true;
            replace(ctx.routine_name(), "EXCEPTION CUSTOM_EXCEPTION");
            delete(ctx.function_argument().argument(0));
            delete(ctx.function_argument().COMMA(0));
        }

    }

//    @Override
//    public void exitFunction_argument(PlSqlParser.Function_argumentContext ctx) {
//        for (ArgumentContext argument : ctx.argument()) {
//            String str = Ora2rdb.getRealName(getRuleText(argument));
//            String[] str2 = str.split("\\(");
//            if (Ora2rdb.procedures_names.contains(str2[0])) {
//                insertBefore(argument, "SELECT RET_VAL FROM ");
//            }
//        }
//    }

    @Override
    public void exitStandard_function(Standard_functionContext ctx) {
        if (ctx.string_function() != null) {
            if (ctx.string_function().NVL() != null)
                replace(ctx.string_function().NVL(), "COALESCE");
            if (ctx.string_function().TO_CHAR() != null) {
                replace(ctx.string_function().TO_CHAR(), "CAST");
                if (ctx.string_function().COMMA(0) != null) {
                    insertBefore(ctx, "UPPER( ");
                    replace(ctx.string_function().COMMA(0), " AS VARCHAR(250) FORMAT");
                    replace(ctx, getRewriterText(ctx) + ")");
                }
                else{
                    insertAfter(ctx.string_function().expression(0), " AS VARCHAR(250)");
                }
            }
            if (ctx.string_function().TO_DATE() != null) {
                replace(ctx.string_function().TO_DATE(), "CAST");
                delete(ctx.string_function().RIGHT_PAREN());
                insertAfter(ctx.string_function().table_element(), " AS TIMESTAMP)");
                delete(ctx.string_function().COMMA(0));
                delete(ctx.string_function().quoted_string());


            }
        }
    }

    @Override
    public void enterStatement(PlSqlParser.StatementContext ctx) {
        current_plsql_block.setStatement(ctx);
    }



    @Override
    public void exitAssignment_statement(Assignment_statementContext ctx) {
        if (ctx.general_element() != null) {
            if (ctx.general_element().general_element_part().size() == 1) {
                General_element_partContext gen_elem_part_ctx = ctx.general_element().general_element_part(0);

                if (gen_elem_part_ctx.id_expression().size() == 1) {
                    String name = Ora2rdb.getRealName(getRuleText(gen_elem_part_ctx.id_expression(0)));

                    if (current_plsql_block != null && current_plsql_block.array_to_table.containsKey(name) &&
                            gen_elem_part_ctx.function_argument() != null) {
                        String insert_stmt = "UPDATE OR INSERT INTO " + current_plsql_block.array_to_table.get(name) + " VALUES (";
                        boolean abort = false;

                        Function_argumentContext func_arg_ctx = gen_elem_part_ctx.function_argument();

                        if (func_arg_ctx.argument().size() == 1)
                            insert_stmt += getRewriterText(func_arg_ctx.argument(0)) + ", ";
                        else {
                            abort = true;
                        }


                        if (!abort) {
                            insert_stmt += getRewriterText(ctx.expression()) + ")";
                            replace(ctx, insert_stmt);
                            return;
                        }
                    }
                }
            }

            String target = getRewriterText(ctx.general_element());

            if (target.startsWith(":"))
                replace(ctx.general_element(), target.substring(1));
        }

        replace(ctx.ASSIGN_OP(), "=");
    }

    @Override
    public void exitIf_statement(If_statementContext ctx) {
        insertBefore(ctx.condition(), "(");
        insertAfter(ctx.condition(), ")");

        if (ctx.seq_of_statements().statement().size() > 1) {
            String indentation = getIndentation(ctx);
            insertAfter(ctx.THEN(), "\n" + indentation + "BEGIN");
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");
        }

        delete(ctx.IF(1));
        delete(ctx.END());
    }

    @Override
    public void exitElsif_part(Elsif_partContext ctx) {
        replace(ctx.ELSIF(), "ELSE IF");
        insertBefore(ctx.condition(), "(");
        insertAfter(ctx.condition(), ")");

        if (ctx.seq_of_statements().statement().size() > 1) {
            String indentation = getIndentation(ctx);
            insertAfter(ctx.THEN(), "\n" + indentation + "BEGIN");
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");
        }
    }

    @Override
    public void exitElse_part(Else_partContext ctx) {
        if (ctx.seq_of_statements().statement().size() > 1) {
            String indentation = getIndentation(ctx);
            insertAfter(ctx.ELSE(), "\n" + indentation + "BEGIN");
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");
        }
    }

    @Override
    public void enterLoop_statement(Loop_statementContext ctx) {

        if (ctx.FOR() != null) {
            if (ctx.cursor_loop_param().DOUBLE_PERIOD() != null) {
                String index_name = Ora2rdb.getRealName((getRuleText(ctx.cursor_loop_param().index_name())));

                if (current_plsql_block != null)
                    if (!current_plsql_block.containsInScope(Ora2rdb.getRealName(getRuleText(ctx))))
                        current_plsql_block.declareVar(index_name);

            }
        }
    }
    @Override
    public void exitLoop_statement(Loop_statementContext ctx) {

        if (ctx.FOR() != null)
            convertLoopFor(ctx);
        if(ctx.WHILE() != null){
            convertLoopWhile(ctx);

        }
    }

    private void convertLoopFor(Loop_statementContext ctx){
        if (ctx.cursor_loop_param().REVERSE() != null && ctx.cursor_loop_param().DOUBLE_PERIOD() != null) {
            String index_name = ctx.cursor_loop_param().index_name().getText();

                if (!loop_index_names.contains(index_name))
                    loop_index_names.add(index_name);

                String target = getRewriterText(ctx.cursor_loop_param().index_name());
                if (target.startsWith(":"))
                    replace(ctx.cursor_loop_param().index_name(), target.substring(1));

                insertBefore(ctx, index_name + " = " + ctx.cursor_loop_param().upper_bound().getText() + ";\n");
                replace(ctx.FOR(), "WHILE (");
                replace(ctx.cursor_loop_param().IN(), " > ");
                delete(ctx.cursor_loop_param().REVERSE());
                delete(ctx.cursor_loop_param().upper_bound());
                delete(ctx.cursor_loop_param().DOUBLE_PERIOD());
                insertBefore(ctx.LOOP(0), ")");
                insertAfter(ctx.seq_of_statements(),'\n'+index_name + " = " + index_name + " + 1;");
            } else if (ctx.cursor_loop_param().DOUBLE_PERIOD() != null) {
                String index_name = ctx.cursor_loop_param().index_name().getText();

                if (!loop_index_names.contains(index_name))
                    loop_index_names.add(index_name);

                String target = getRewriterText(ctx.cursor_loop_param().index_name());
                if (target.startsWith(":"))
                    replace(ctx.cursor_loop_param().index_name(), target.substring(1));

                insertBefore(ctx, index_name + " = " + ctx.cursor_loop_param().lower_bound().getText() + ";\n");
                replace(ctx.FOR(), "WHILE (");
                replace(ctx.cursor_loop_param().IN(), " < ");
                delete(ctx.cursor_loop_param().lower_bound());
                delete(ctx.cursor_loop_param().DOUBLE_PERIOD());
                insertBefore(ctx.LOOP(0), ")");
                insertAfter(ctx.seq_of_statements(),'\n'+index_name + " = " + index_name + " + 1;");
            }
            insertBefore(ctx.condition(), "(");
            insertAfter(ctx.condition(), ")");
            replace(ctx.LOOP(0), "DO");

            String indentation = getIndentation(ctx);
            insertAfter(ctx.LOOP(0), "\n" + indentation + "BEGIN");
            insertAfter(ctx.seq_of_statements(), "\n" + indentation + "END");

        delete(ctx.END());
        delete(ctx.LOOP(1));
    }
    public void convertLoopWhile(Loop_statementContext ctx){
        insertBefore(ctx.condition(), "(");
        insertAfter(ctx.condition(), ")");
        insertAfter(ctx.condition(),  " DO\n");
        insertBefore(ctx.seq_of_statements(), "BEGIN\n");
        delete(ctx.LOOP(0));
        delete(ctx.LOOP(1));

          }
    @Override
    public void exitReturn_statement(Return_statementContext ctx) {
        String returnVal = getRewriterText(ctx.expression());

        if (returnVal.startsWith(":"))
            replace(ctx.expression(), returnVal.substring(1));


        if (current_plsql_block != null) {
            if (Ora2rdb.out_parameters_in_procedure.containsKey(current_plsql_block.procedure_name)) {
                TreeSet<String> parameter_set = new TreeSet<>(Ora2rdb.out_parameters_in_procedure.
                        get(current_plsql_block.procedure_name).keySet());
                StringBuilder return_parameters = new StringBuilder();
                for (String parameter_name : parameter_set) {

                    return_parameters.append(parameter_name).append("_OUT = ").append(parameter_name).append(";\n");

                }
                if (ctx.expression() != null) {
                    String indentation = getIndentation(ctx);
                    replace(ctx, "RET_VAL = " + getRewriterText(ctx.expression()) + ";\n" +return_parameters.toString()+
                            indentation + "SUSPEND;\n" +
                            indentation + "EXIT");
                } else
                    replace(ctx, "EXIT");
            }
        }
    }
    @Override
    public void enterSeq_of_statements(Seq_of_statementsContext ctx) {
        pushScope();
    }

    @Override
    public void exitSeq_of_statements(Seq_of_statementsContext ctx) {
        for (int i = 0; i < ctx.statement().size(); i++) {
            StatementContext stmt_ctx = ctx.statement(i);

            if (stmt_ctx.if_statement() != null ||
                    stmt_ctx.loop_statement() != null ||
                    stmt_ctx.body() != null)
                delete(ctx.SEMICOLON(i));
        }
        popScope();
    }
}
