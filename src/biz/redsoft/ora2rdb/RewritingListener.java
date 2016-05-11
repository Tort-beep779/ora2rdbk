package biz.redsoft.ora2rdb;

import org.antlr.v4.runtime.*;

import biz.redsoft.ora2rdb.plsqlParser.*;

public class RewritingListener extends plsqlBaseListener {
	TokenStreamRewriter rewriter;
	TokenStream tokens;
	
	public RewritingListener(TokenStream tokens) {
		rewriter = new TokenStreamRewriter(tokens);
		this.tokens = tokens;
	}
	
	@Override
	public void enterCreate_table(Create_tableContext ctx) {
		if (ctx.schema_name() != null)
		{
			Schema_nameContext sch = ctx.schema_name();
			rewriter.delete(sch.start, sch.stop);
			rewriter.delete(ctx.PERIOD().getSymbol());
		}
		
		if (ctx.physical_properties() != null)
			rewriter.delete(ctx.physical_properties().start, ctx.physical_properties().stop);
		
		if (ctx.lob_storage_clause().size() != 0)
			rewriter.delete(ctx.lob_storage_clause(0).start, ctx.lob_storage_clause(ctx.lob_storage_clause().size() - 1).stop);
	}
	
	@Override
	public void enterField_spec(Field_specContext ctx) {
		if (ctx.type_spec() != null)
		{
			if (ctx.type_spec().datatype() != null)
				if (ctx.type_spec().datatype().native_datatype_element() != null)
					if (ctx.type_spec().datatype().native_datatype_element().RAW() != null)
					{
						rewriter.replace(ctx.type_spec().start, ctx.type_spec().stop, "SMALLINT [0:10]");
						
						if (ctx.default_value_part() != null)
							rewriter.delete(ctx.default_value_part().start, ctx.default_value_part().stop);
					}
		}
	}
	
	@Override
	public void enterDatatype(DatatypeContext ctx) {
		if (ctx.native_datatype_element() != null)
		{
			if (ctx.native_datatype_element().NUMBER() != null)
			{
				if (ctx.precision_part() != null)
				{
					if (ctx.precision_part().ASTERISK() == null)
						rewriter.replace(ctx.native_datatype_element().start, ctx.native_datatype_element().stop, "NUMERIC");
					else
						rewriter.replace(ctx.start, ctx.stop, "SMALLINT");
				}
			}
			else if (ctx.native_datatype_element().FLOAT() != null)
			{
				if (ctx.precision_part() != null)
					rewriter.replace(ctx.start, ctx.stop, "DOUBLE PRECISION");
			}
			else if (ctx.native_datatype_element().TIMESTAMP() != null)
			{
				if (ctx.precision_part() != null)
					rewriter.delete(ctx.precision_part().start, ctx.precision_part().stop);
			}
		}
	}
	
	@Override
	public void enterPrecision_part(Precision_partContext ctx) {
		if (ctx.BYTE() != null)
			rewriter.delete(ctx.BYTE().getSymbol());
		else if (ctx.CHAR() != null)
			rewriter.delete(ctx.CHAR().getSymbol());
	}
	
	@Override
	public void enterNative_datatype_element(Native_datatype_elementContext ctx) {
		if (ctx.VARCHAR2() != null)
			rewriter.replace(ctx.start, "VARCHAR");
		else if (ctx.DATE() != null)
			rewriter.replace(ctx.start, "TIMESTAMP");
		else if (ctx.CLOB() != null)
			rewriter.replace(ctx.start, "BLOB SUB_TYPE 1");
	}
}
