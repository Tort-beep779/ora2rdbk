package ru.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.TreeMap;

public interface StoredBlock {

    boolean equal(StoredBlock storedBlock);
    boolean containOutParameters();
    boolean equal(FinderBlockCall finder, boolean withTypeConversion);
    boolean equalsIgnoreParent (FinderBlockCall finder, boolean withTypeConversion);
    boolean equalsIgnoreParameters (FinderBlockCall finder);

    String getName();
    void setName(String name);

    String getParamType(String name);
    TreeMap<Integer, Parameter> getParameters();
    void setParameters(Integer sequence_number, String name, String type, boolean is_out);
    void setParameters(Integer sequence_number, String name, String type);
    void setParameters(Integer sequence_number, PlSqlParser.ParameterContext ctx, boolean is_out);
    void setParameters(Integer sequence_number, PlSqlParser.Variable_declarationContext ctx, boolean is_out);

    ArrayList<Parameter> getDeclaredVariables();
    void setDeclaredVariables(String name,String type);
    void setDeclaredVariables(PlSqlParser.Variable_declarationContext ctx);

    StoredBlock getParent();
    void setParent(StoredBlock parent);

    ArrayList<StoredBlock> getChildren();
    void setChildren(StoredBlock children);

    String getPackage_name();
    void setPackage_name(String package_name);



     ArrayList<StoredBlock> getCalledStorageBlocks();
     void setCalledStorageBlocks(StoredBlock calledStorageBlocks);


}
