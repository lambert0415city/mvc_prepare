package com.cs.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.activemq.command.ActiveMQMapMessage;
import org.apache.activemq.command.ActiveMQObjectMessage;
import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.jms.core.JmsMessagingTemplate;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import javax.annotation.Resource;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.ObjectMessage;
import java.io.Serializable;
import java.util.Date;

/**
 * @author: szh
 * @since:
 */
@Slf4j
public class ActiveMqUtilsBoot {

    @Resource
    private JmsTemplate jmsTemplate;

    @Resource
    private JmsMessagingTemplate jmsMessagingTemplate;

    @Resource
    private ThreadPoolTaskExecutor threadPoolTaskExecutor;

    public void sendQueueMesage(String name, Object message){
        Destination destination= new ActiveMQQueue(name);
        jmsMessagingTemplate.convertAndSend(destination,message);
    }

    public Object receive(String destination) throws JMSException,NullPointerException {
        ObjectMessage objectMessage = (ObjectMessage) jmsMessagingTemplate.receive(destination);
        System.out.println("从队列" + destination.toString() + "收到了消息：\t" + objectMessage);
        return objectMessage;
    }


    public void sendMapMessage(String queueName, Object message) {
        threadPoolTaskExecutor.submit(() -> {
            try {
                Destination destination = new ActiveMQQueue(queueName);
                // 这里定义了Queue的key
                ActiveMQMapMessage mqMapMessage = new ActiveMQMapMessage();
                mqMapMessage.setJMSDestination(destination);
                mqMapMessage.setObject("result", message);
                this.jmsMessagingTemplate.convertAndSend(destination, mqMapMessage);
            } catch (Throwable e) {
                log.error("{}", e);
            }
        });
    }

    public void sendObjectMessage(String queueName, Object message) {
        threadPoolTaskExecutor.submit(() -> {
            try {
                log.info("发送添加好友请求:{}",message.toString());
                Destination destination = new ActiveMQQueue(queueName);
                // 这里定义了Queue的key
                ActiveMQObjectMessage mqObjectMessage = new ActiveMQObjectMessage();
                mqObjectMessage.setJMSDestination(destination);
                mqObjectMessage.setObject((Serializable) message);
                this.jmsMessagingTemplate.convertAndSend(destination, mqObjectMessage);
            } catch (Throwable e) {
                log.error("{}", e);
            }
        });
    }

    public void sendObjectMessage(Destination destination, Object message) {
        threadPoolTaskExecutor.submit(() -> {
            Date date = new Date();
            try {
                // 这里定义了Queue的key
                log.info("【queue-->send】:activeCount={},queueCount={},completedTaskCount={},taskCount={}", threadPoolTaskExecutor.getThreadPoolExecutor().getActiveCount(), threadPoolTaskExecutor.getThreadPoolExecutor().getQueue().size(), threadPoolTaskExecutor.getThreadPoolExecutor().getCompletedTaskCount(), threadPoolTaskExecutor.getThreadPoolExecutor().getTaskCount());

                ActiveMQObjectMessage mqObjectMessage = new ActiveMQObjectMessage();
                mqObjectMessage.setJMSDestination(destination);
                mqObjectMessage.setObject((Serializable) message);
                this.jmsMessagingTemplate.convertAndSend(destination, mqObjectMessage);
            } catch (Throwable e) {
                log.error("{}", e);
            }
        });
    }



}
