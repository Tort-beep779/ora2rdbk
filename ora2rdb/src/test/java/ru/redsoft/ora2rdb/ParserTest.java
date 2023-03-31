package ru.redsoft.ora2rdb;

import org.junit.jupiter.api.Test;

import java.io.*;
import java.nio.charset.*;
import java.nio.file.*;
import com.github.difflib.DiffUtils;
import com.github.difflib.UnifiedDiffUtils;
import com.github.difflib.patch.Patch;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

class ParserTest {
    private List readFile(String path) throws IOException {
        List<String> str = new ArrayList<>();
        BufferedReader reader = new BufferedReader
                (new InputStreamReader(
                        new FileInputStream("src/test/resources/"+path), StandardCharsets.UTF_8));
        String line;
        while ((line = reader.readLine()) != null) {
            str.add(line);
        }
        return str;
    }

    void test(String file) throws IOException {
        List<String> expected = readFile("output/" + file);

        RewritingListener rewritingListener =
                Ora2rdb.convert(new FileInputStream("src/test/resources/input/" + file));
        List<String> actual = Arrays.asList(rewritingListener.rewriter.getText().replace("\r", "").split("\n"));

        Patch diff = DiffUtils.diff(expected, actual);
        List<String> unifiedDiff = UnifiedDiffUtils.generateUnifiedDiff("expected", "actual", expected, diff, 0);
        String result = String.join("\n", unifiedDiff);
        assertEquals("", result);
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

    @Test
    void constraintsTest() throws IOException {
        test("constraints.sql");
    }

    @Test
    void hrOraTest() throws IOException {
        test("hr_ora.sql");
    }

}