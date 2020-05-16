package com.cs.activedemo2no;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;
import javax.jms.TextMessage;

import com.cs.pojo.Users;
import org.apache.log4j.Logger;

/**
 * @author: szh
 * @since:
 */
public class ObjectMessageLisnter implements MessageListener{
    private static Logger logger = Logger.getLogger(ObjectMessageLisnter.class);


    @Override
    public void onMessage(Message msg) {
        if(msg instanceof ObjectMessage) {
            ObjectMessage tm = (ObjectMessage) msg;
            try {
                logger.info("从消息队列中消费一个对象！！");
                Users u = (Users) tm.getObject();
                logger.info(u.toString());
                //具体的业务逻辑
                //seckillService.consumeSeckillAction(sa);

            } catch (JMSException e) {
                e.printStackTrace();
            }
        } else if(msg instanceof TextMessage) {
            //do sth....
        }
    }
}
