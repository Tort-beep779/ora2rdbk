package ru.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.Stack;
import java.util.TreeMap;
import java.util.TreeSet;

public class PLSQLBlock {
    Stack<TreeSet<String>> scopes = new Stack<TreeSet<String>>();

    ArrayList<String> trigger_fields = new ArrayList<String>();
    String trigger_when_condition;

    TreeMap<String, ArrayType> array_types = new TreeMap<String, ArrayType>();
    TreeMap<String, String> array_to_table = new TreeMap<String, String>();
    ArrayList<String> temporary_tables_ddl = new ArrayList<String>();

    private static TreeSet<String> used_temporary_table_names = new TreeSet<String>();

    class ArrayType {
        String data_type;
        ArrayList<String> index_types = new ArrayList<String>();
    }

    PLSQLBlock() {
        pushScope();
    }

    void pushScope() {
        scopes.push(new TreeSet<String>());
    }

    void popScope() {
        scopes.pop();
    }

    void declareVar(String var_name) {
        scopes.peek().add(var_name);
    }

    boolean containsInScope(String var_name) {
        for (TreeSet<String> scope : scopes)
        {
            if (scope.contains(var_name))
                return true;
        }

        return false;
    }

    void declareTypeOfArray(String name, String type, String index_type) {
        ArrayType new_arr_type = new ArrayType();

        if (array_types.containsKey(type))
        {
            ArrayType arr_type = array_types.get(type);
            new_arr_type.data_type = arr_type.data_type;
            new_arr_type.index_types.addAll(arr_type.index_types);
            new_arr_type.index_types.add(0, index_type);
        }
        else
        {
            new_arr_type.data_type = type;
            new_arr_type.index_types.add(index_type);
        }

        array_types.put(name, new_arr_type);
    }

    void declareArray(String name, String type) {
        if (array_types.containsKey(type))
        {
            ArrayType arr_type = array_types.get(type);
            String new_name = name;

            for (int i = 1; ; i++)
            {
                if (used_temporary_table_names.contains(new_name))
                    new_name = name + i;
                else
                    break;
            }

            used_temporary_table_names.add(new_name);
            array_to_table.put(name, new_name);
            StringBuilder key_fields = new StringBuilder();
            StringBuilder table_ddl = new StringBuilder("CREATE GLOBAL TEMPORARY TABLE " + new_name + " (\n");

            for (int i = 0; i < arr_type.index_types.size(); i++)
            {
                if (i != 0)
                    key_fields.append(", ");

                table_ddl.append("\tI" + (i + 1) + " " + arr_type.index_types.get(i) + ",\n");
                key_fields.append("I").append(i + 1);
            }

            table_ddl.append("\tVAL " + arr_type.data_type + ",\n\tCONSTRAINT PK_" + new_name + " PRIMARY KEY (" + key_fields + ")\n);");
            temporary_tables_ddl.add(table_ddl.toString());
        }
    }
}
