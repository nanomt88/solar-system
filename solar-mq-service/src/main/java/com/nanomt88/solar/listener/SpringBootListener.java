//package com.nanomt88.solar.listener;
//
//import com.alibaba.fastjson.JSON;
//import com.nanomt88.solar.entity.Subscribe;
//import com.nanomt88.solar.service.SubscribeService;
//import com.nanomt88.solar.watch.ConsumerListener;
//import com.nanomt88.solar.watch.ZookeeperClient;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.ApplicationListener;
//import org.springframework.context.event.ContextRefreshedEvent;
//import org.springframework.stereotype.Component;
//
//import java.util.List;
//
///**
// * @author nanomt88@gmail.com
// * @create 2017-09-03 17:09
// **/
////@Component
//public class SpringBootListener  implements ApplicationListener<ContextRefreshedEvent> {
//
//    @Autowired
//    private SubscribeService subscribeService;
//
//    private void registerConsumer() throws Exception {
//        List<Subscribe> list = this.subscribeService.findAllSubscribe();
//
//        ZookeeperClient client = ZookeeperClient.getInstance();
//
//        for (Subscribe subscribe : list) {
//            ConsumerListener listener = new ConsumerListener();
//            String json = JSON.toJSONString(subscribe);
//            boolean register = client.register(subscribe.getProname(), json,
//                    listener);
//            //如果以前注册过，则手动初始化所有的consumer
//            if(!register){
//                //手动调用初始化consumer方法
//                listener.onCreate(json);
//            }
//        }
//    }
//
//    /**
//     * 但是这个时候，会存在一个问题，在web 项目中（spring mvc），系统会存在两个容器，一个是root application context ,
//     * 		另一个就是我们自己的 projectName-servlet  context（作为root application context的子容器）。
//     * 		这种情况下，就会造成onApplicationEvent方法被执行两次。为了避免上面提到的问题，我们可以只在
//     * 		root application context初始化完成后调用逻辑代码，其他的容器的初始化完成，则不做任何处理，修改后代码
//     * @param event
//     */
//    @Override
//    public void onApplicationEvent(ContextRefreshedEvent event) {
//        if(event.getApplicationContext().getParent() == null){//root application context 没有parent，他就是老大.
//            //需要执行的逻辑代码，当spring容器初始化完成后就会执行该方法。
//            //注册consumer
//            try {
//                registerConsumer();
//            } catch (Exception e) {
//                e.printStackTrace();
//                System.exit(-1);
//            }
//        }
//    }
//
//}
