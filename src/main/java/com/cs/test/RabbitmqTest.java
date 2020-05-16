package com.cs.test;

import com.cs.pojo.RabbitMessage;
import com.cs.rabbitmqdemo.RmqConsumer;
import com.cs.rabbitmqdemo.RmqProducer;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import java.util.HashMap;
import java.util.Map;
/**
 * @author: szh
 * @since:
 */

/**
 * @author sanglp
 * @create 2018-02-06 14:36
 * @desc mq测试类
 **/
public class RabbitmqTest {
    private RmqProducer rmqProducer ;
    private RmqConsumer rqmConsumer ;
    @Before
    public void setUp() throws Exception {
        //ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("D:/web-back/web-back/myweb/web/WEB-INF/applicationContext.xml");
        //context.start();

        String path="web/WEB-INF/applicationContext.xml";
        ApplicationContext context = new FileSystemXmlApplicationContext(path);
        rmqProducer = (RmqProducer) context.getBean("rmqProducer");
        rqmConsumer = (RmqConsumer)context.getBean("rqmConsumer");
    }
    @Test
    public void test(){
        String exchange = "testExchange";
        String routeKey ="testQueue";
        String methodName = "test";
        //参数
        for (int i=0;i<10;i++){
            Map<String,Object> param=new HashMap<String, Object>();
            param.put("data","hello");

            RabbitMessage msg=new RabbitMessage(exchange,routeKey, methodName, param);
            //发送消息
            rmqProducer.sendMessage(msg);
        }

        // rqmConsumer.rmqProducerMessage(msg);

    }
}
