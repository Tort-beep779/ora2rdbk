package biz.redsoft.ora2rdb;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.TreeMap;
import java.util.TreeSet;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class Ora2rdb {
	public static TreeMap<String, TreeSet<String>> table_map = new TreeMap<String, TreeSet<String>>();
	public static TreeSet<String> index_names = new TreeSet<String>();
	
	public static void main(String[] args) throws Exception {
		InputStream is;
		
		if (args.length > 0)
			is = new FileInputStream(args[0]);
		else
			is = System.in;

		ANTLRInputStream input = new ANTLRInputStream(is);
		plsqlLexer lexer = new plsqlLexer(input);
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		plsqlParser parser = new plsqlParser(tokens);
		ParseTree tree = parser.compilation_unit();
		
		ParseTreeWalker walker = new ParseTreeWalker();
		
		InitialListener init_listener = new InitialListener();
		walker.walk(init_listener, tree);
		//System.out.println(init_listener.table_map.toString());
		
		RewritingListener converter = new RewritingListener(tokens);
		walker.walk(converter, tree);
		System.out.println(converter.rewriter.getText());
	}
}
