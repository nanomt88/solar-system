package com.nanomt88.solar.watch;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.rocketmq.client.exception.MQClientException;
import com.nanomt88.solar.entity.Subscribe;
import com.nanomt88.solar.listener.EnvironmentUtil;
import com.nanomt88.solar.mq.MQConsumer;
import com.nanomt88.solar.mq.MQFactory;
import com.nanomt88.solar.mq.MQListener;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import java.util.HashMap;
import java.util.Map;

/**
 * mq consumer 监听器
 *
 * @author nanomt88@gmail.com
 * @create 2017-09-03 8:22
 **/
public class ConsumerListener implements NodeChangeEventHandle {

    private Subscribe subscribe;

    @Override
    public void onCreate(String json) {
        Subscribe subscribe = parseJson(json);
        if(subscribe == null){
            return;
        }
        this.subscribe = subscribe;
        start(subscribe);
    }

    @Override
    public void onUpdate(String json) {
        Subscribe subscribe = parseJson(json);
        if(subscribe == null){
            return;
        }
        this.subscribe = subscribe;
        //先停止消费
        stop(subscribe);
        //然后再开始
        start(subscribe);

    }

    @Override
    public void onDelete(String json) {
        //停止消费
        stop(subscribe);
        this.subscribe = null;
    }

    private void stop(Subscribe subscribe){
        String proName = subscribe.getProname();
        //停止服务
        MQFactory.getInstance().stopConsumer(proName);
    }

    private Subscribe parseJson(String json){
        return JSONObject.parseObject(json, Subscribe.class);
    }

    private void start(Subscribe subscribe){
        String proName = subscribe.getProname();
        //consumerId 自定义规则
        String url = subscribe.getUrl();
        String topic = subscribe.getTopic();
        String tag = subscribe.getTag();
        String groupName = subscribe.getGroupName();
        String businessKey = subscribe.getBusinesskey();
        String status = subscribe.getStatus();
        String updateTime = DateFormatUtils.format(subscribe.getUpdateTime(), "yyyy-MM-dd HH:mm:ss");
        System.out.println(updateTime);

        //配置参数：
        Map<String, String> options = new HashMap<String, String>();
        String consumeGroup = subscribe.getConsumeGroup();
        options.put("consumeGroup", consumeGroup);
        String consumeFromWhere = subscribe.getConsumefromwhere();
        options.put("consumeFromWhere", consumeFromWhere);
        String consumeThreadMin = subscribe.getConsumethreadmin();
        options.put("consumeThreadMin", consumeThreadMin);
        String consumeThreadMax = subscribe.getConsumethreadmax();
        options.put("consumeThreadMax", consumeThreadMax);
        String pullThresholdForQueue = subscribe.getPullthresholdforqueue();
        options.put("pullThresholdForQueue", pullThresholdForQueue);
        String consumeMessageBatchMaxSize = subscribe.getConsumemessagebatchmaxsize();
        options.put("consumeMessageBatchMaxSize", consumeMessageBatchMaxSize);
        String pullBatchSize = subscribe.getPullbatchsize();
        options.put("pullBatchSize", pullBatchSize);
        String pullInterval = subscribe.getPullinterval();
        options.put("pullInterval", pullInterval);

        //创建Consumer
        MQListener mqListener = new MQListener(proName, proName, url, businessKey);
        //传递参数
        MQFactory.getInstance().createConsumer(proName,
                groupName,
                EnvironmentUtil.getProperty("rocketmq.nameservers"),
                topic,
                tag,
                mqListener,
                options);
    }
}
