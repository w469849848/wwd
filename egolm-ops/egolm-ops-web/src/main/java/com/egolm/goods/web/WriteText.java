package com.egolm.goods.web;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.springframework.plugin.util.FileUtil;

public class WriteText {

	public static void main(String[] args) {
		/*String ss = "写入个文字";
		String fileName = "d:\\uploadError.txt";
		appendMethod(fileName,ss);*/
		
		String json = ",202,203,1,8,27,28,29,30,31,32,33,34,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,";
		System.out.println(json.indexOf(",9,"));
	}
	public static void appendMethod(String fileName, String content) {
        try {
            //打开一个写文件器，构造函数中的第二个参数true表示以追加形式写文件
            FileWriter writer = new FileWriter(fileName, true);
            writer.write(content+"\n");
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
