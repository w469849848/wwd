package com.egolm.promo;

import java.io.File;
import java.sql.SQLException;

import org.springframework.plugin.jdbc.dialect.SqlServerTo;

public class DB {

	private static final String root = "D:/Green/myeclipse-workspace/egolm-workspace/egolm/egolm-domain/src/main/java";
	
	public static void main(String[] args) throws SQLException {
		System.out.println("Directory: " + root);
		File[] files = new File(root).listFiles();
		for(File file : files) {
			System.out.println("Delete: " + file.getAbsolutePath());
			file.deleteOnExit();
		}
		new SqlServerTo(root, "com.egolm.domain", "曲欣亮", "10.10.0.51:1433", "EgoShop30", "sa", "qiyang").executeFilter("tYWPromoExtends");
	}
	
}
