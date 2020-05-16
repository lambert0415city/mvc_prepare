package com.cs.activedemo;

import javax.annotation.Resource;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.TextMessage;

import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Service;

/**
 * @author: szh
 * @since:
 */
@Service
public class ConsumerService {

    @Resource(name="jmsTemplate")
    private JmsTemplate jmsTemplate;

    /**
     * 接收消息
     */
    public TextMessage receive(Destination destination) throws JMSException{
        TextMessage tm = (TextMessage) jmsTemplate.receive(destination);
//        try {
//            if(tm.getText() != null){
//                System.out.println("从队列" + destination.toString() + "收到了消息：\t"
//                        + tm.getText());
//            }
//        } catch (JMSException e) {
//            e.printStackTrace();
//        }

        return tm;

    }

}
