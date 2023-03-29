package ru.redsoft.ora2rdb;

import org.junit.jupiter.api.Test;

import java.io.*;
import java.nio.charset.*;
import java.nio.file.*;


import static org.junit.jupiter.api.Assertions.*;

class ParserTest {
    private String readFile(String path, Charset encoding) throws IOException {
        return Files.readString(Paths.get("src/test/resources/"+path), encoding);
    }

    void test(String file) throws IOException {
        String expected = readFile("output/" + file, StandardCharsets.UTF_8);

        RewritingListener rewritingListener =
                Ora2rdb.convert(new FileInputStream("src/test/resources/input/" + file));
        String actual = rewritingListener.rewriter.getText().replace("\r", "");
        assertEquals(expected, actual);
    }

    @Test
    void createTableTest() throws IOException {
        test("create_table.sql");
    }

    @Test
    void createTableWithStorageTest() throws IOException {
        test("create_table_with_storage.sql");
    }

    @Test
    void fullTest() throws IOException {
        test("full.sql");
    }

    @Test
    void functionsTest() throws IOException {
        test("functions.sql");
    }

    @Test
    void indexesTest() throws IOException {
        test("indexes.sql");
    }

    @Test
    void proceduresTest() throws IOException {
        test("procedures.sql");
    }

    @Test
    void sequencesTest() throws IOException {
        test("sequences.sql");
    }

    @Test
    void triggersTest() throws IOException {
        test("triggers.sql");
    }

    @Test
    void viewsTest() throws IOException {
        test("views.sql");
    }

}