package com.nanomt88.solar.listener;

import javax.servlet.ServletContextEvent;

import com.alibaba.fastjson.JSON;
import com.nanomt88.solar.entity.Subscribe;
import com.nanomt88.solar.service.SubscribeService;
import com.nanomt88.solar.watch.ConsumerListener;
import com.nanomt88.solar.watch.ZookeeperClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.alibaba.druid.proxy.DruidDriver;

import java.util.List;

/**
 * <br>类 名: SpringContextLoaderListener
 * <br>描 述: Spring环境加载监听器
 * <br>创 建： 2013年5月6日
 * <br>版 本：v1.0.0
 * <br>
 * <br>历 史: (版本) 作者 时间 注释
 */
public class SpringContextLoaderListener extends ContextLoaderListener {

    @Autowired
    private SubscribeService subscribeService;

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        //注销所有的consumer
        ZookeeperClient.getInstance().unRegisterAllHandle();

        super.contextDestroyed(event);
        System.out.println("销毁...");

    }

    private Logger log = LoggerFactory.getLogger(SpringContextLoaderListener.class);

    @Override
    public void contextInitialized(ServletContextEvent event) {
        super.contextInitialized(event);
        System.out.println("启动开始...");
        //设置容器
        new ApplicationFactory().setApplicationContext(WebApplicationContextUtils.getWebApplicationContext(event.getServletContext()));
        ApplicationContext context = ApplicationFactory.getContext();
        //设置环境变量
        EnvironmentUtil.setEnvironment(context.getEnvironment());
        if(subscribeService == null){
            subscribeService = (SubscribeService) context.getBean("subscribeService");
        }
        try {
            registerConsumer();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void registerConsumer() throws Exception {
        List<Subscribe> list = this.subscribeService.findAllSubscribe();

        ZookeeperClient client = ZookeeperClient.getInstance();

        for (Subscribe subscribe : list) {
            ConsumerListener listener = new ConsumerListener();
            String json = JSON.toJSONString(subscribe);
            boolean register = client.register(subscribe.getProname(), json,
                    listener);
            //如果以前注册过，则手动初始化所有的consumer
            if(!register){
                //手动调用初始化consumer方法
                listener.onCreate(json);
            }
        }
    }
}
