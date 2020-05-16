package com.cs.rabbitmqdemo;

import com.cs.pojo.RabbitMessage;

/**
 * @author: szh
 * @since:
 */
public class RmqConsumer {
    public void rmqProducerMessage(Object object){
        System.out.println("消费前");
        RabbitMessage rabbitMessage = (RabbitMessage) object;
        System.out.println(rabbitMessage.getExchange());
        System.out.println(rabbitMessage.getRoutekey());
        System.out.println(rabbitMessage.getParams().toString());
    }
}
