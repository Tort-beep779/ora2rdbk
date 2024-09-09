package ru.redsoft.ora2rdb;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;

public class StoredAnonymousBlock implements StoredBlock {

    private List<Parameter> declaredVariables = new ArrayList<>();
    private boolean isNested = false;


    @Override
    public boolean equal(StoredBlock storedBlock) {
        return false;
    }

    @Override
    public boolean containOutParameters() {
        return false;
    }

    @Override
    public boolean equal(FinderBlockCall finder, boolean withTypeConversion) {
        return false;
    }

    @Override
    public boolean equalsIgnoreParent(FinderBlockCall finder, boolean withTypeConversion) {
        return false;
    }

    @Override
    public boolean equalsIgnoreParameters(FinderBlockCall finder) {
        return false;
    }

    @Override
    public String getName() {
        return null;
    }

    @Override
    public void setName(String name) {

    }

    @Override
    public String getParamType(String name) {
        return declaredVariables.stream()
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
    public void setParameters(Integer sequence_number, PlSqlParser.ParameterContext ctx, boolean is_out) {

    }

    @Override
    public void setParameters(Integer sequence_number, PlSqlParser.Variable_declarationContext ctx, boolean is_out) {

    }

    @Override
    public ArrayList<Parameter> getDeclaredVariables() {
        return null;
    }

    @Override
    public void setDeclaredVariables(String name, String type) {
        Parameter parameter = new Parameter();
        parameter.setType(type);
        parameter.setName(name);
        parameter.setOut(false);
        this.declaredVariables.add(parameter) ;
    }

    public void setIsNested(boolean isNested){
        this.isNested = isNested;
    }

    public boolean getIsNested(){
        return this.isNested;
    }

    @Override
    public void setDeclaredVariables(PlSqlParser.Variable_declarationContext ctx) {

    }

    @Override
    public StoredBlock getParent() {
        return null;
    }

    @Override
    public void setParent(StoredBlock parent) {

    }

    @Override
    public ArrayList<StoredBlock> getChildren() {
        return null;
    }

    @Override
    public void setChildren(StoredBlock children) {

    }

    @Override
    public String getPackage_name() {
        return null;
    }

    @Override
    public void setPackage_name(String package_name) {

    }

    @Override
    public ArrayList<StoredBlock> getCalledStorageBlocks() {
        return null;
    }

    @Override
    public void setCalledStorageBlocks(StoredBlock calledStorageBlocks) {

    }


}
