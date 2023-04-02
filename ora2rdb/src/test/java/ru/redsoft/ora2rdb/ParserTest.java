package ru.redsoft.ora2rdb;

import org.junit.jupiter.api.Test;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;

import com.github.difflib.DiffUtils;
import com.github.difflib.UnifiedDiffUtils;
import com.github.difflib.patch.Patch;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ParserTest {
    private List<String> readFile(String path) throws IOException {
        return Files.readAllLines(Path.of("src/test/resources/" + path), StandardCharsets.UTF_8);
    }

    void test(String file) throws IOException {
        List<String> expected = readFile("output/" + file);

        try (FileInputStream fs = new FileInputStream("src/test/resources/input/" + file)) {
            RewritingListener rewritingListener =
                    Ora2rdb.convert(fs);
            List<String> actual = Arrays.asList(rewritingListener.rewriter.getText()
                    .replace("\r", "").split("\n"));

            Patch<String> diff = DiffUtils.diff(expected, actual);
            List<String> unifiedDiff = UnifiedDiffUtils.generateUnifiedDiff("expected",
                    "actual", expected, diff, 0);
            String result = String.join("\n", unifiedDiff);
            assertEquals("", result);
        }
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