package com.cs.activedemo2no;


import com.cs.pojo.Users;

import javax.jms.Destination;


/**
 * @author: szh
 * @since:
 */
public interface MQProducerService {
    /** 发送一个对象到指定的目标(Queue或者Topic)
     * @param destination 目的地
     * @param u 数据传输对象
     */
    void sendSeckillMessage(Destination destination, final Users u);

    /** 发送一个对象到默认的destination 可以通过jmsTemplate自动获取
     * @param u 数据传输对象
     */
    void sendSeckillMessage(final Users u);

}
