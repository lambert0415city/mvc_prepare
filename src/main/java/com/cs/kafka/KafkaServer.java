package com.cs.kafka;
import org.apache.kafka.clients.producer.Callback;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

 /**
 * @author: szh
 * @since:
 */


@Service
public class KafkaServer {
     KafkaTemplate<String,String> kafkaTemplate;

     private String topic;

     public void setTopic(String topic) {
         this.topic = topic;
     }

     public void setKafkaTemplate(KafkaTemplate kafkaTemplate) {
         this.kafkaTemplate = kafkaTemplate;
     }


     /**
      * 代码创建: yellowcong <br/>
      * 创建日期: 2019年3月18日 <br/>
      * 功能描述: 异步发送日志到kafka中
      */
     public void sendLogAsyn(final String log) {
         try {
             //走我们设定的默认的topic
             kafkaTemplate.send(topic,log);
         } catch (Exception e) {
             e.printStackTrace();
//             AppLog.kafka.error(e.getMessage());
         }
     }


     /**
      * 代码创建: yellowcong <br/>
      * 创建日期: 2019年3月18日 <br/>
      * 功能描述: 同步发送日志到kafka中
      */
     public void sendLogSync(final String log ) {
         try {
             kafkaTemplate.send(null,log).get();
         } catch (Exception e) {
             e.printStackTrace();
         }
     }

}
