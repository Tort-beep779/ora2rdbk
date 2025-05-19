package ru.redsoft.ora2rdb;

import java.io.*;
import java.util.*;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class Ora2rdb {
    public static boolean reorder = false;
    private static StringBuilder errors = new StringBuilder();
    final static String errorMessage = "Found error(s) in file while parsing\n";
    private final static String packageBodyStart = "CREATE OR REPLACE PACKAGE BODY package_for_parse IS";
    private final static String packageEnd = "END package_for_parse;";
    private final static String packageStart = "CREATE OR REPLACE PACKAGE package_for_parse IS";

    static String stripQuotes(String str) {
        if (str.startsWith("\""))
            return str.substring(1, str.length() - 1);
        else
            return str;
    }

    static String getRealName(String str) {
        if (str.startsWith("\""))
            return str.substring(1, str.length() - 1);
        else
            return str.toUpperCase();
    }

    static String getRealParameterName(String str) {
        return str.toUpperCase()
                .substring(str.lastIndexOf(".") + 1,
                           str.length()
                );
    }

    static void printUsage() {
        System.err.println("Usage: ora2rdb.jar <input_file> [options]\n" +
                "Options:\n" +
                "    -o <output_file>    Specify output file.\n" +
                "    -r                  Reorder CREATE VIEW statements in according to their\n" +
                "                        dependencies. It allows to perform FORCE clause\n" +
                "                        conversion. Use this option only for scripts which\n" +
                "                        contain DB metadata.\n" +
                "Notes:\n" +
                "    \"stdin\" may be used as a value of <input_file>.");
    }

    static RewritingListener convert(InputStream is) throws IOException {
        SqlCodeParser sqlCodeParser = new SqlCodeParser();
        List<String> splitBlocks = sqlCodeParser.splitMetadataIntoBlocks(is);

        StringBuilder mergedBlocks = convertSplitBlocks(splitBlocks, sqlCodeParser);

        CharStream input = CharStreams.fromString(mergedBlocks.toString());
        PlSqlLexer lexer = new PlSqlLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        PlSqlParser parser = new PlSqlParser(tokens);
        parser.setErrorHandler(new BailErrorStrategy());
        ParserRuleContext tree;
        tree = parser.sql_script();

        mergedBlocks.setLength(0);
        errors.setLength(0);

        ParseTreeWalker walker = new ParseTreeWalker();

        ScanListener scan_listener = new ScanListener();
        walker.walk(scan_listener, tree);

        RewritingListener converter = new RewritingListener(tokens);
        walker.walk(converter, tree);


//        StorageInfo.clearInfo();
        return converter;
    }

    private static StringBuilder convertSplitBlocks(List<String> splitBlocks, SqlCodeParser sqlCodeParser) {
        Map<Integer, List<String>> mapWithBlocksInPackages = sqlCodeParser.getBlocksInPackage();
        StringBuilder mergedBlocks = new StringBuilder();
        int numberOfBlock = 0;
        for (String singleBlock : splitBlocks) {
            if (mapWithBlocksInPackages.containsKey(numberOfBlock)) {
                StringBuilder insidePackage = new StringBuilder();
                List<String> listWithBlocks = mapWithBlocksInPackages.get(numberOfBlock);
                for (int id = 0; id < listWithBlocks.size() - 2; id++) {
                    String startOfPackage = packageBodyStart;
                    if (sqlCodeParser.checkIfPragmaDeclaration(listWithBlocks.get(id))) {
                        startOfPackage = packageStart;
                    }
                    String singleBlockInPackage = tryToParseBlock(startOfPackage + " " + listWithBlocks.get(id) + " " + packageEnd).toString();
                    singleBlockInPackage = singleBlockInPackage.replace(startOfPackage, "");
                    singleBlockInPackage = singleBlockInPackage.replace(packageEnd, "");
                    insidePackage.append(singleBlockInPackage);
                }
                int size = listWithBlocks.size();
                StringBuilder parsedPackageDeclaration = tryToParseBlock(listWithBlocks.get(size - 2) + " " + listWithBlocks.get(size - 1));
                String[] splitPackageDeclaration = sqlCodeParser.findLastIndexOfEndSubstring(parsedPackageDeclaration.toString());
                mergedBlocks.append("\n\n\n").append(splitPackageDeclaration[0]).append(insidePackage).append(splitPackageDeclaration[1]);
            } else {
                mergedBlocks.append(tryToParseBlock(singleBlock));
            }
            numberOfBlock++;
        }
        if (errors.length() != 0) {
            errors.insert(0, errorMessage);
            errors.insert(0, "/*");
            errors.append("*/").append("\n\n\n");
            errors.append(mergedBlocks);
            mergedBlocks.setLength(0);
            mergedBlocks.append(errors);
        }
        return mergedBlocks;
    }

    private static StringBuilder tryToParseBlock(String block) {
        StringBuilder parsedBlock = new StringBuilder();
        CustomErrorListener customErrorListener = new CustomErrorListener();
        try {
            CharStream input = CharStreams.fromString(block);
            PlSqlLexer lexer = new PlSqlLexer(input);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            PlSqlParser parser = new PlSqlParser(tokens);
            parser.setErrorHandler(new BailErrorStrategy());
            parser.removeErrorListeners();
            parser.addErrorListener(customErrorListener);
            ParserRuleContext tree = parser.sql_script();
            parsedBlock.append(block);
        } catch (Exception e) {
            block = block.replaceAll("/\\*", "").replaceAll("\\*/", "");
            List<String> errorList = customErrorListener.getErrorMessages();
            parsedBlock.append("\n").append("/*");
            for (String s : errorList) {
                errors.append(s).append("\n");
                parsedBlock.append("\n").append(s);
            }
            parsedBlock.append("\n").append(block).append("\n").append("*/");
        }
        return parsedBlock;
    }

    public static void main(String[] args) throws Exception {
        InputStream is;
        PrintStream ps = System.out;
        String output_file = null;

        if (args.length > 0) {
            if (args[0].equals("stdin")) {
                is = System.in;
            } else {
                try {
                    is = new FileInputStream(args[0]);
                } catch (Exception e) {
                    System.err.println("Unable to open: " + args[0]);
                    return;
                }
            }

            for (int i = 1; i < args.length; i++) {
                switch (args[i]) {
                    case "-o":
                        if (i < args.length - 1) {
                            i++;
                            output_file = args[i];
                        } else {
                            System.err.println("Missing argument for option: " + args[i]);
                            printUsage();
                            return;
                        }

                        break;

                    case "-r":
                        reorder = true;
                        break;

                    default:
                        System.err.println("Unknown option: " + args[i]);
                        printUsage();
                        return;
                }
            }
        } else {
            printUsage();
            return;
        }

        RewritingListener converter;
        try {
            converter = convert(is);
        } catch (Exception e) {
            System.err.println(e.fillInStackTrace());
            System.err.println("Output will not be generated");
            return;
        }

        if (output_file != null) {
            try {
                ps = new PrintStream(output_file);
            } catch (Exception e) {
                System.err.println("Unable to write: " + output_file);
                return;
            }
        }

        if (reorder)
            ps.print(converter.getText());
        else
            ps.print(converter.rewriter.getText());

        StorageInfo.clearInfo();

        ps.close();
    }
}
