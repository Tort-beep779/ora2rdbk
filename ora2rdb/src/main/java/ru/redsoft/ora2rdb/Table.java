package ru.redsoft.ora2rdb;

import java.util.TreeMap;

public class Table {
    private String name;
    private TreeMap<String, String> columns = new TreeMap<>();

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public TreeMap<String, String> getColumns() {
        return columns;
    }

    public void setColumn(String name, String type) {
        columns.put(name,type);
    }
}