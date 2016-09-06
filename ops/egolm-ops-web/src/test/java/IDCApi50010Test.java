

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.plugin.jdbc.JdbcTemplate;

import com.egolm.domain.TShop;
import com.egolm.idc.api.IDCExecutorApi;

public class IDCApi50010Test {

	ClassPathXmlApplicationContext ctx;
	IDCExecutorApi api;
	
	@Test
	public void JdbcT() {
		TShop tShop = new TShop();
		tShop.setnShopID(36151);
		tShop.setsEmail("egolm@egolm.com");
		JdbcTemplate jdbcTemplate = ctx.getBean(JdbcTemplate.class);
		jdbcTemplate.merge(tShop);
	}
	
	@Before
	public void before() {
		ctx = new ClassPathXmlApplicationContext("spring-test.xml");
		api = (IDCExecutorApi)ctx.getBean("executor");
	}
	
	@After
	public void after() {
		ctx.close();
	}
	
}
