package ru.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.Objects;
import java.util.TreeMap;

public class StoredTrigger implements StoredBlock{

    private String name;
//    private TreeMap<Integer, Parameter> parameters = new TreeMap<>();
    private Table table_view;
    private ArrayList<Parameter> declaredVariables = new ArrayList<>();
    private StoredBlock parent;
    private ArrayList<StoredBlock> children = new ArrayList<>();
    private ArrayList<StoredFunction> calledFunctions = new ArrayList<>();
    private ArrayList<StoredProcedure> calledProcedure = new ArrayList<>();
    private ArrayList<StoredBlock> calledStorageBlocks = new ArrayList<>();
//    private String package_name;
//    private String maybe_package_name;

    private boolean equalTriggerNames(StoredTrigger trigger) {
        return Objects.equals(this.name, trigger.getName());
    }
    private boolean equalsTrigger(StoredTrigger trigger) {
        return equalTriggerNames(trigger);
    }

    @Override
    public boolean equals(StoredBlock storedBlock) {
        if(storedBlock instanceof StoredTrigger){
            return equalsTrigger((StoredTrigger)storedBlock);
        }
        return false;
    }



    @Override
    public boolean containOutParameters() {
        return false;
    }

    @Override
    public boolean equals(FinderBlockCall finder) {
        return false;
    }

    @Override
    public boolean equalsIgnoreParent(FinderBlockCall finder) {
        return false;
    }

    @Override
    public boolean equalsIgnoreParameters(FinderBlockCall finder) {
        return false;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    public Table getTable_view() {
        return table_view;
    }

    public void setTable_view(Table table_view) {
        this.table_view = table_view;
        for (String column : table_view.getColumns().keySet()){
            Parameter parameter = new Parameter();
            parameter.setName(column);
            parameter.setType(table_view.getColumns().get(column));
            declaredVariables.add(parameter);
        }
    }

    @Override
    public String getParamType(String name) {
        return   declaredVariables.stream()
                .filter(e -> e.getName().equals(name))
                .findFirst().orElse(new Parameter()).getType();
    }

    @Override
    public TreeMap<Integer, Parameter> getParameters() {
        return null;
    }

    @Override
    public void setParameters(Integer sequence_number, String name, String type, boolean is_out) {

    }

    @Override
    public void setParameters(Integer sequence_number, String name, String type) {

    }

    @Override
    public ArrayList<Parameter> getDeclaredVariables() {
        return declaredVariables;
    }

    @Override
    public void setDeclaredVariables(String name, String type) {
        Parameter parameter = new Parameter();
        parameter.setType(type);
        parameter.setName(name);
        parameter.setOut(false);
        this.declaredVariables.add(parameter);
    }

    @Override
    public StoredBlock getParent() {
        return parent;
    }

    @Override
    public void setParent(StoredBlock parent) {
        this.parent = parent;
    }

    @Override
    public ArrayList<StoredBlock> getChildren() {
        return children;
    }

    @Override
    public void setChildren(StoredBlock children) {

    }

    @Override
    public String getPackage_name() {
        return "";
    }

    @Override
    public void setPackage_name(String package_name) {

    }



    @Override
    public ArrayList<StoredBlock> getCalledStorageBlocks() {
        return calledStorageBlocks;
    }

    @Override
    public void setCalledStorageBlocks(StoredBlock calledBlock) {
        this.calledStorageBlocks.add(calledBlock);
        if(calledBlock instanceof StoredFunction)
            this.calledFunctions.add((StoredFunction) calledBlock);
        else if(calledBlock instanceof StoredProcedure)
            this.calledProcedure.add((StoredProcedure) calledBlock);
    }

    public ArrayList<StoredFunction> getCalledFunctions() {
        return calledFunctions;
    }

    public ArrayList<StoredProcedure> getCalledProcedure() {
        return calledProcedure;
    }


}
