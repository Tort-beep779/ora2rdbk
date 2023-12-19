package ru.redsoft.ora2rdb;

import java.util.TreeMap;
import java.util.TreeSet;
import ru.redsoft.ora2rdb.PlSqlParser.*;

public class ScanListener extends PlSqlParserBaseListener {
    String currentProcedureName;

    @Override
    public void enterCreate_package_body(Create_package_bodyContext ctx) {
        for (Package_obj_bodyContext obj_body : ctx.package_obj_body()) {
            if (obj_body.type_declaration() != null) {
                Type_declarationContext type = obj_body.type_declaration();
                if (type.record_type_def() != null) {
                    for (Field_specContext field_spec : type.record_type_def().field_spec()) {
                        if (field_spec.type_spec() != null) {
                            Type_specContext typeSpec = field_spec.type_spec();
                            if (typeSpec.type_name() != null) {
                                String tableName = Ora2rdb.getRealName(typeSpec.type_name().id_expression(0).getText());
                                String columnName = Ora2rdb.getRealName(typeSpec.type_name().id_expression(1).getText());
                                if (Ora2rdb.types_of_column.containsKey(tableName)) {
                                    Ora2rdb.types_of_column.get(tableName).put(columnName, null);
                                } else {
                                    TreeMap<String, String> unknown_column_type = new TreeMap<>();
                                    unknown_column_type.put(columnName, null);
                                    Ora2rdb.types_of_column.put(tableName, unknown_column_type);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @Override
    public void enterAlter_table(Alter_tableContext ctx) {
        Column_clausesContext columns_ctx = ctx.column_clauses();
        Constraint_clausesContext constraint_clauses_ctx = ctx.constraint_clauses();

        if (columns_ctx != null) {
            Add_modify_drop_column_clausesContext add_modify_drop_column_clauses_ctx = columns_ctx.add_modify_drop_column_clauses();
            if (add_modify_drop_column_clauses_ctx != null) {
                if (add_modify_drop_column_clauses_ctx.constraint_clauses() != null) {
                    Modify_column_clausesContext modify_column_clauses_ctx = add_modify_drop_column_clauses_ctx.modify_column_clauses(0);
                    if (!modify_column_clauses_ctx.modify_col_properties().isEmpty()) {
                        Modify_col_propertiesContext modify_col_properties_ctx = modify_column_clauses_ctx.modify_col_properties(0);

                        if (!modify_col_properties_ctx.inline_constraint().isEmpty()) {
                            Inline_constraintContext inline_constraint_ctx = modify_col_properties_ctx.inline_constraint(0);

                            if (inline_constraint_ctx.NOT() != null && inline_constraint_ctx.NULL_() != null) {
                                String table_name = Ora2rdb.getRealName(ctx.tableview_name().id_expression().getText());
                                String column_name = Ora2rdb.getRealName(modify_col_properties_ctx.column_name().getText());

                                if (Ora2rdb.table_not_null_cols.containsKey(table_name)) {
                                    Ora2rdb.table_not_null_cols.get(table_name).add(column_name);
                                } else {
                                    TreeSet<String> columns_set = new TreeSet<String>();
                                    columns_set.add(column_name);
                                    Ora2rdb.table_not_null_cols.put(table_name, columns_set);
                                }
                            }
                        }
                    }
                }
            }
        } else if (constraint_clauses_ctx != null) {
            if (!constraint_clauses_ctx.out_of_line_constraint().isEmpty()) {
                Out_of_line_constraintContext out_of_line_constraint_ctx = constraint_clauses_ctx.out_of_line_constraint(0);

                if (out_of_line_constraint_ctx.PRIMARY() != null) {
                    TreeSet<String> columns_set = new TreeSet<String>();

                    for (Column_nameContext column_name_ctx : out_of_line_constraint_ctx.column_name())
                        columns_set.add(Ora2rdb.getRealName(column_name_ctx.getText()));

                    String table_name = Ora2rdb.getRealName(ctx.tableview_name().id_expression().getText());

                    if (Ora2rdb.table_not_null_cols.containsKey(table_name))
                        Ora2rdb.table_not_null_cols.get(table_name).addAll(columns_set);
                    else
                        Ora2rdb.table_not_null_cols.put(table_name, columns_set);
                }
                if (out_of_line_constraint_ctx.PRIMARY() != null)
                    Ora2rdb.index_names.add(Ora2rdb.getRealName(out_of_line_constraint_ctx.constraint_name().getText()));
                else if (out_of_line_constraint_ctx.UNIQUE() != null)
                    Ora2rdb.index_names.add(Ora2rdb.getRealName(out_of_line_constraint_ctx.constraint_name().getText()));
                else if (out_of_line_constraint_ctx.foreign_key_clause() != null) {
                    if (out_of_line_constraint_ctx.foreign_key_clause().FOREIGN() != null)
                        Ora2rdb.index_names.add(Ora2rdb.getRealName(out_of_line_constraint_ctx.constraint_name().getText()));

                }


            }
        }
    }

    @Override
    public void enterCreate_procedure_body(Create_procedure_bodyContext ctx) {
        String procedureName;
        if (ctx.procedure_name().id_expression() != null) {
            procedureName = Ora2rdb.getRealName(ctx.procedure_name().id_expression().getText());
            Ora2rdb.procedures_names.add(procedureName);
        } else {
            procedureName = Ora2rdb.getRealName(ctx.procedure_name().identifier().id_expression().getText());
            Ora2rdb.procedures_names.add(procedureName);
        }
        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                if (!ctx.parameter(i).OUT().isEmpty()) {
                    String parameter_name = Ora2rdb.getRealName(ctx.parameter(i).parameter_name().getText());
                    if (Ora2rdb.out_parameters_in_procedure.containsKey(procedureName)) {
                        Ora2rdb.out_parameters_in_procedure.get(procedureName).put(parameter_name, i);
                    } else {
                        TreeMap<String, Integer> parameter_set = new TreeMap<>();
                        parameter_set.put(parameter_name, i);
                        Ora2rdb.out_parameters_in_procedure.put(procedureName, parameter_set);
                    }
                }
            }
        }
        currentProcedureName = procedureName;
    }

    @Override
    public void exitCreate_procedure_body(Create_procedure_bodyContext ctx) {
        currentProcedureName = null;
    }

    @Override
    public void enterProcedure_body(Procedure_bodyContext ctx) {

        String procedureName = Ora2rdb.getRealName(ctx.identifier().id_expression().getText());
        Ora2rdb.procedures_names.add(procedureName);
        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                if (!ctx.parameter(i).OUT().isEmpty()) {
                    String parameter_name = Ora2rdb.getRealName(ctx.parameter(i).parameter_name().getText());
                    if (currentProcedureName != null) {
                        if (Ora2rdb.procedures_with_out_parameters.containsKey(currentProcedureName)) {
                            if (Ora2rdb.procedures_with_out_parameters.get(currentProcedureName).containsKey(procedureName)) {
                                Ora2rdb.procedures_with_out_parameters.get(currentProcedureName).get(procedureName).put(parameter_name, i);
                            } else {
                                TreeMap<String, Integer> parameter_set = new TreeMap<>();
                                parameter_set.put(parameter_name, i);
                                Ora2rdb.procedures_with_out_parameters.get(currentProcedureName).put(procedureName, parameter_set);
                            }
                        } else {
                            TreeMap<String, TreeMap<String, Integer>> out_parameters_in_procedure = new TreeMap<>();
                            TreeMap<String, Integer> parameter_set = new TreeMap<>();
                            parameter_set.put(parameter_name, i);
                            out_parameters_in_procedure.put(procedureName, parameter_set);
                            Ora2rdb.procedures_with_out_parameters.put(currentProcedureName, out_parameters_in_procedure);
                        }
                    } else if (Ora2rdb.out_parameters_in_procedure.containsKey(procedureName)) {
                        Ora2rdb.out_parameters_in_procedure.get(procedureName).put(parameter_name, i);
                    } else {
                        TreeMap<String, Integer> parameter_set = new TreeMap<>();
                        parameter_set.put(parameter_name, i);
                        Ora2rdb.out_parameters_in_procedure.put(procedureName, parameter_set);
                    }
                }
            }
        }
        currentProcedureName = procedureName;
    }

    @Override
    public void exitProcedure_body(Procedure_bodyContext ctx) {
        currentProcedureName = null;
    }

    @Override
    public void enterCreate_function_body(Create_function_bodyContext ctx) {
        String functionName;
        if (ctx.function_name().id_expression() != null) {
            functionName = Ora2rdb.getRealName(ctx.function_name().id_expression().getText());
            Ora2rdb.procedures_names.add(functionName);
        } else {
            functionName = Ora2rdb.getRealName(ctx.function_name().identifier().id_expression().getText());
            Ora2rdb.procedures_names.add(functionName);
        }

        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                if (!ctx.parameter(i).OUT().isEmpty()) {
                    Ora2rdb.function_returns_type.put(functionName, getConvertType(ctx.type_spec()));
                    String parameter_name = Ora2rdb.getRealName(ctx.parameter(i).parameter_name().getText());
                    if (Ora2rdb.out_parameters_in_function.containsKey(functionName)) {
                        Ora2rdb.out_parameters_in_function.get(functionName).put(parameter_name, i);
                    } else {
                        TreeMap<String, Integer> parameter_set = new TreeMap<>();
                        parameter_set.put(parameter_name, i);
                        Ora2rdb.out_parameters_in_function.put(functionName, parameter_set);

                    }
                }

            }
        }
        currentProcedureName = functionName;
    }

    @Override
    public void enterFunction_body(Function_bodyContext ctx) {
        String functionName = Ora2rdb.getRealName(ctx.identifier().id_expression().getText());

        if (ctx.parameter() != null) {
            for (int i = 0; i < ctx.parameter().size(); i++) {
                if (!ctx.parameter(i).OUT().isEmpty()) {
                    Ora2rdb.procedures_names.add(functionName);
                    String parameter_name = Ora2rdb.getRealName(ctx.parameter(i).parameter_name().getText());
                    if (currentProcedureName != null) {
                        TreeMap<String, String> functionReturnType = new TreeMap<>();
                        functionReturnType.put(functionName, getConvertType(ctx.type_spec()));
                        Ora2rdb.function_returns_type_with_parent.put(currentProcedureName, functionReturnType);
                        if (Ora2rdb.functions_with_out_parameters.containsKey(currentProcedureName)) {
                            if (Ora2rdb.functions_with_out_parameters.get(currentProcedureName).containsKey(functionName)) {
                                Ora2rdb.functions_with_out_parameters.get(currentProcedureName).get(functionName).put(parameter_name, i);
                            } else {
                                TreeMap<String, Integer> parameter_set = new TreeMap<>();
                                parameter_set.put(parameter_name, i);
                                Ora2rdb.functions_with_out_parameters.get(currentProcedureName).put(functionName, parameter_set);
                            }
                        } else {
                            TreeMap<String, TreeMap<String, Integer>> out_parameters_in_function = new TreeMap<>();
                            TreeMap<String, Integer> parameter_set = new TreeMap<>();
                            parameter_set.put(parameter_name, i);
                            out_parameters_in_function.put(functionName, parameter_set);
                            Ora2rdb.functions_with_out_parameters.put(currentProcedureName, out_parameters_in_function);
                        }
                    } else if (Ora2rdb.out_parameters_in_function.containsKey(functionName)) {
                        Ora2rdb.out_parameters_in_function.get(functionName).put(parameter_name, i);
                        Ora2rdb.function_returns_type.put(functionName, getConvertType(ctx.type_spec()));
                    } else {
                        TreeMap<String, Integer> parameter_set = new TreeMap<>();
                        parameter_set.put(parameter_name, i);
                        Ora2rdb.out_parameters_in_function.put(functionName, parameter_set);
                        Ora2rdb.function_returns_type.put(functionName, getConvertType(ctx.type_spec()));
                    }
                }
            }
        }
    }

    @Override
    public void enterCreate_view(Create_viewContext ctx) {
        Ora2rdb.views.put(Ora2rdb.getRealName(ctx.id_expression(0).getText()), new View(ctx));
    }

    private String getConvertType(Type_specContext ctx) { //todo переделать стандартные значения
        String type = Ora2rdb.getRealName(ctx.getText());
        if (ctx.datatype() != null) {
            DatatypeContext datatype = ctx.datatype();
            if (datatype.native_datatype_element() != null) {
                Native_datatype_elementContext nde = datatype.native_datatype_element();

                if (nde.VARCHAR2() != null || nde.NVARCHAR2() != null)
                    type = "VARCHAR (4000)";
                else if (nde.NUMBER() != null)
                    type = "NUMERIC (18, 4)";
                else if (nde.BINARY_FLOAT() != null)
                    type = "FLOAT";
                else if (nde.BINARY_DOUBLE() != null)
                    type = "DOUBLE PRECISION";
                else if (nde.NCHAR() != null)
                    type = "CHAR (250)";
                else if (nde.BINARY_INTEGER() != null)
                    type = "INTEGER";
            }
        }
        return type;
    }
}
