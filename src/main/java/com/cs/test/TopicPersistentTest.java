package com.cs.test;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.junit.Test;

import javax.jms.*;

/**
 * 第一种：消息持久化到本地文件
 * Topic 消息持久化订阅测试
 * @author: szh
 * @since:
 */
public class TopicPersistentTest {
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

        //毫秒
        producer.send(message,DeliveryMode.NON_PERSISTENT,1,1000*60*60*24);

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

        //  ###设置客户端id (设置持久化)
        connection.setClientID("client-1");
        //连接mq服务
        connection.start();
        //获得seesion对象
        final Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        //t通过seesion对象创建主题
        Topic topic = session.createTopic("itheimaTopic");

        //通过session对象创建主题的发送者
        //        MessageConsumer consumer = session.createConsumer(topic);

        // ###客户端持久化订阅
        TopicSubscriber consumer = session.createDurableSubscriber(topic, "client1-sub");

        //监听
        consumer.setMessageListener(new MessageListener() {
            //监听topic中存在消息，执行方法
            @Override
            public void onMessage(Message message) {
                TextMessage textMessage = (TextMessage) message;
                try {
                    System.out.println("消费者接收到" + textMessage.getText());
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
