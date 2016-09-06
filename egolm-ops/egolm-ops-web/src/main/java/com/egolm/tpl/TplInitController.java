package com.egolm.tpl;

import java.io.Writer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.util.Egox;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.egolm.tpl.generator.TemplateHtmlGenerator;

@Controller
@RequestMapping("/tpl/init")
public class TplInitController {
	
	@Autowired
	TemplateHtmlGenerator htmlGenerator;

	@RequestMapping("/execute")
	public void execute(Writer writer) throws Exception {
		htmlGenerator.execute();
		Egox.egoxOk().write(writer);
	}
	
}
