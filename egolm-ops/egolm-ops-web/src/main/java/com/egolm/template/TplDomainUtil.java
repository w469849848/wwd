package com.egolm.template;

import java.sql.SQLException;

import org.springframework.plugin.jdbc.dialect.SqlServerTo;

public class TplDomainUtil {
	
	private static final String root = "D:\\Green\\myeclipse-workspace\\egolm-workspace\\egolm\\egolm-domain\\src\\main\\java";
	
	public static void main(String[] args) throws SQLException {
		SqlServerTo s = new SqlServerTo(root, "com.egolm.domain", "曲欣亮", "10.10.0.51:1433", "EgoShop30", "sa", "qiyang");
		s.execute("tTplPage", null);
		s.execute("tTplFloor", null);
		s.execute("tTplTab", null);
		s.execute("tTplCell", null);
		s.execute("tTplIcon", null);
	}

}
