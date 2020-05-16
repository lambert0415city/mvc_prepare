package com.cs.test;

import javax.annotation.Resource;

import com.cs.activedemo2no.MQProducerService;
import com.cs.pojo.Users;
import org.junit.Test;
//import org.springframework.test.context.ContextConfiguration;
/**
 * @author: szh
 * @since:
 */
/*单元测试类*/
//@RunWith(org.springframework.test.context.junit4.SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations="classpath:applicationContext.xml")
public class ObjectMessageTest {
    @Resource
    MQProducerService mqProducerService;

    @Test
    public void testRole() {
        Long sid = new Long(1000);
        Integer uid = 1;
        Users sa = new Users(1,"10","10","10","10");
        mqProducerService.sendSeckillMessage(sa);
    }
}
