package ru.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.List;

public class Index {
    private String indexName;
    private String unique;
    private String tableSpace;
    private String tableName;
    private boolean systemIndex;
    private List<String> functionalIndexes = new ArrayList<>();
    private List<String> columnIndexes = new ArrayList<>();

    public Index(String indexName, String unique, String tableSpace, String tableName, boolean systemIndex){
        this.indexName = indexName;
        this.unique = unique;
        this.tableSpace = tableSpace;
        this.tableName = tableName;
        this.systemIndex = systemIndex;
    }


    public String getIndexName() {
        return indexName;
    }

    public String getTableName() {
        return tableName;
    }

    public String getTableSpace() {
        return tableSpace;
    }

    public String getUnique() {
        return unique;
    }

    public boolean getSystemIndex(){
        return systemIndex;
    }

    public void setFunctionalIndexes(String name){
        functionalIndexes.add(name);
    }
    public int getNumberOfFunctionalIndexes(){
        return functionalIndexes.size();
    }

    public void setColumnIndexes(String name){
        columnIndexes.add(name);
    }
    public int getNumberOfColumnIndexes(){
        return columnIndexes.size();
    }
}


