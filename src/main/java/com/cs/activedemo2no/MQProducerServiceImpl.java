package com.cs.activedemo2no;

import com.cs.pojo.Users;

import javax.jms.Destination;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.ObjectMessage;
import javax.jms.Session;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;


/**
 * @author: szh
 * @since:
 */
public class MQProducerServiceImpl implements MQProducerService{

    @Autowired
    JmsTemplate jmsTemplate;

    Logger logger = Logger.getLogger(MQProducerServiceImpl.class);

    @Override
    public void sendSeckillMessage(Destination destination, Users u) {
        logger.info("向队列" + destination.toString() + "发送对象" + u.getClass());
        jmsTemplate.send(destination, new MessageCreator() {

            @Override
            public Message createMessage(Session session) throws JMSException {
                ObjectMessage om = session.createObjectMessage(u);
                return om;
            }
        });
    }

    @Override
    public void sendSeckillMessage(Users u) {
        Destination dest = jmsTemplate.getDefaultDestination();
        sendSeckillMessage(dest, u);
    }
}
