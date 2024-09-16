package ru.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public  interface TypeConversion {

    ArrayList<String> STRINGS = new ArrayList<>(List.of(
            "CHAR", "VARCHAR", "VARCHAR2", "NCHAR", "NVARCHAR2"));

    ArrayList<String> NUMBERS = new ArrayList<>(List.of(
            "NUMERIC", "NUMBER", "INTEGER", "INT", "SMALLINT", "FLOAT", "BINARYFLOAT", "BINARYDOUBLE"));

    ArrayList<String> NUMERIC = new ArrayList<>(){{
        addAll(STRINGS);
        addAll(NUMBERS);
    }};
    ArrayList<String> TEXT = new ArrayList<>(){{
        addAll(STRINGS);
        addAll(NUMBERS);
        add("DATE");
        add("LONG");
        add("ROWID");
        add("RAW");
        add("CLOB");
        add("NCLOB");
    }};
    ArrayList<String> CHAR = new ArrayList<>(){{
        addAll(STRINGS);
        addAll(NUMBERS);
        add("DATE");
        add("LONG");
        add("RAW");
        add("BLOB");
        add("CLOB");
        add("NCLOB");
    }};
    ArrayList<String> DATE = new ArrayList<>(){{
        addAll(STRINGS);
        add("DATE");
    }};





    HashMap<String, ArrayList<String>> conversion_type = new HashMap<>() {{
        put("NUMERIC", NUMERIC);
        put("NUMBER", NUMERIC);
        put("INTEGER", NUMERIC);
        put("INT", NUMERIC);
        put("SMALLINT", NUMERIC);
        put("FLOAT", NUMERIC);
        put("DOUBLEPRECISION", NUMERIC);
        put("CHAR", CHAR);
        put("VARCHAR", TEXT);
        put("VARCHAR2", TEXT);
        put("NCHAR", TEXT);
        put("NVARCHAR2", TEXT);
        put("DATE", DATE);
//        put("LONG", CHAR);
    }};



}
