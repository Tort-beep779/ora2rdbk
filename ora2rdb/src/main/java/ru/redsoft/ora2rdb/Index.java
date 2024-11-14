package ru.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.List;

public class Index {
    private String indexName;
    private String unique;
    private String tableSpace;
    private String tableName;
    private boolean isSystemIndex;
    private List<String> functionalIndexes = new ArrayList<>();
    private List<String> columnIndexes = new ArrayList<>();
    private boolean isOriginalNameInUse = true;

    public Index(String indexName, String unique, String tableSpace, String tableName, boolean systemIndex) {
        this.indexName = indexName;
        this.unique = unique;
        this.tableSpace = tableSpace;
        this.tableName = tableName;
        this.isSystemIndex = systemIndex;
    }

    public String indexName() {
        return indexName;
    }

    public String tableName() {
        return tableName;
    }

    public String tableSpace() {
        return tableSpace;
    }

    public String unique() {
        return unique;
    }

    public boolean isSystemIndex() {
        return isSystemIndex;
    }

    public void setFunctionalIndexes(String name) {
        functionalIndexes.add(name);
    }

    public int getNumberOfFunctionalIndexes() {
        return functionalIndexes.size();
    }

    public List<String> functionalIndexes() {
        return functionalIndexes;
    }

    public void setColumnIndexes(String name) {
        columnIndexes.add(name);
    }

    public int getNumberOfColumnIndexes() {
        return columnIndexes.size();
    }

    public List<String> columnIndexes() {
        return columnIndexes;
    }

    public void setIsOriginalNameInUse(boolean isOriginalNameInUse) {
        this.isOriginalNameInUse = isOriginalNameInUse;
    }

    public boolean isOriginalNameInUse() {
        return isOriginalNameInUse;
    }
}


