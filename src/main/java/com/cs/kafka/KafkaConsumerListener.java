package com.cs.kafka;

/**
 * @author: szh
 * @since:
 */

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.listener.MessageListener;

public class KafkaConsumerListener implements MessageListener<String, String> {

//    @Autowired
//    PvuvService logService;

    @Override
    public void onMessage(ConsumerRecord<String, String> data) {

        //监听messge的处理
//		logService.countPvUv(data.value());
        System.out.println("获取到数据:\t"+data.value());
    }

}
