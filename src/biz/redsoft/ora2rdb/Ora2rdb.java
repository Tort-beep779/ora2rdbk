package biz.redsoft.ora2rdb;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.TreeMap;
import java.util.TreeSet;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class Ora2rdb {
	public static TreeMap<String, TreeSet<String>> table_map = new TreeMap<String, TreeSet<String>>();
	public static TreeSet<String> index_names = new TreeSet<String>();
	
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
	
	static void printUsage() {
		System.err.println("Usage: ora2rdb.jar <input_file> [options]\n"
				+ "Options:\n"
				+ "\t-o <output_file>\n"
				+ "Notes:\n"
				+ "\t\"stdin\" may be used as a value of <input_file>");
	}
	
	public static void main(String[] args) throws Exception {
		InputStream is;
		PrintStream ps = System.out;
		String output_file = null;
		
		if (args.length > 0)
		{
			if (args[0].equals("stdin"))
			{
				is = System.in;
			}
			else
			{
				try
				{
					is = new FileInputStream(args[0]);
				}
				catch (Exception e)
				{
					System.err.println("Unable to open: " + args[0]);
					return;
				}
			}
			
			for (int i = 1; i < args.length; i++)
			{
				switch (args[i])
				{
				case "-o":
					if (i < args.length - 1)
					{
						i++;
						output_file = args[i];
					}
					else
					{
						System.err.println("Missing argument for option: " + args[i]);
						printUsage();
						return;
					}
					
					break;
					
				default:
					System.err.println("Unknown option: " + args[i]);
					printUsage();
					return;
				}
			}
		}
		else
		{
			printUsage();
			return;
		}

		CharStream input = CharStreams.fromStream(is);
		plsqlLexer lexer = new plsqlLexer(input);
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		plsqlParser parser = new plsqlParser(tokens);
		parser.setErrorHandler(new BailErrorStrategy());
		ParserRuleContext tree;
		
		try
		{
			tree = parser.sql_script();
		} 
		catch (Exception e)
		{
			System.err.println("Output will not be generated");
			return;
		}

		ParseTreeWalker walker = new ParseTreeWalker();
		
		InitialListener init_listener = new InitialListener();
		walker.walk(init_listener, tree);
		//System.out.println(init_listener.table_map.toString());
		
//		RewritingListener converter = new RewritingListener(tokens);
//		walker.walk(converter, tree);
		
		RewritingVisitor rv = new RewritingVisitor(parser);
		
		if (output_file != null)
		{
			try
			{
				ps = new PrintStream(output_file);
			}
			catch (Exception e)
			{
				System.err.println("Unable to write: " + output_file);
				return;
			}
		}
		
		//ps.print(converter.rewriter.getText());
		ps.print(rv.visit(tree));
		ps.close();
	}
}
