package com.cs.test;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.junit.Test;

import javax.jms.*;

/**
 * @author: szh
 * @since:
 */
public class activeMQTest {
    //消息发送方

    @Test
    public void test1() throws JMSException {
        //创建工厂对象
        ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory("tcp://localhost:61616");
        //工厂中获取连接对象
        Connection connection = connectionFactory.createConnection();
        //连接mq服务
        connection.start();
        //获得seesion对象
        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        //t通过seesion对象创建主题
        Topic topic = session.createTopic("itheimaTopic");

        //通过session对象创建主题的发送者
        MessageProducer producer = session.createProducer(topic);

        //创建消息
        TextMessage message = session.createTextMessage("ping2");

        producer.send(message);

        //关闭相关资源
        producer.close();
        session.close();
        connection.close();

    }


    /**
     * 接收方
     * @throws JMSException
     */
    @Test
    public void test2() throws JMSException {
        //创建工厂对象
        ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory("tcp://localhost:61616");
        //工厂中获取连接对象
        Connection connection = connectionFactory.createConnection();
        //连接mq服务
        connection.start();
        //获得seesion对象
        final Session session = connection.createSession(false, Session.CLIENT_ACKNOWLEDGE);

        //t通过seesion对象创建主题
        Topic topic = session.createTopic("itheimaTopic");

        //通过session对象创建主题的发送者
        MessageConsumer consumer = session.createConsumer(topic);

        //监听
        consumer.setMessageListener(new MessageListener() {
            //监听topic中存在消息，执行方法
            @Override
            public void onMessage(Message message) {
                TextMessage textMessage = (TextMessage) message;
                try {
                    if(("ping").equals(textMessage.getText())){
                        System.out.println("消费者接收到" + textMessage.getText());
                        message.acknowledge();
                    }else {
                        System.out.println("消息失败了");
                        //消息重发,最多可以重发6次
                        session.recover();
                        int i = 1/0;

                    }

                } catch (JMSException e) {
                    e.printStackTrace();
                }
            }
        });
        //不需要关闭资源

        while (true){

        }
    }
}
