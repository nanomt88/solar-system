package com.nanomt88.solar.watch;

import com.nanomt88.solar.listener.ApplicationFactory;
import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.framework.recipes.cache.PathChildrenCache;
import org.apache.curator.framework.recipes.cache.PathChildrenCacheEvent;
import org.apache.curator.framework.recipes.cache.PathChildrenCacheListener;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * zk client 工厂类
 *
 * @author nanomt88@gmail.com
 * @create 2017-09-02 22:10
 **/
@PropertySource("classpath:rocketmq.properties")
public class ZookeeperClient {

    /** 定义session失效时间 */
    public static final int SESSION_TIMEOUT = 5000;

    private CuratorFramework cf = null;

    private static String PARENT_NODE = "/config";

    private static String SEPARATOR = "/";

    @Autowired
    private Environment environment;

    private static ZookeeperClient CLIENT = null;

    /**
     * 监控节点变化
     */
    private static Map<String, NodeChangeEventHandle> HANDLE = new ConcurrentHashMap();

    private ZookeeperClient(){
        environment = ApplicationFactory.getContext().getEnvironment();

        String connection_addr =  environment.getProperty("zookeeper.address");
        //1. 重试策略： 初试时间为1秒，重试10次
        RetryPolicy retryPolicy = new ExponentialBackoffRetry(1000, 10);
        //2  通过工厂创建连接
        cf = CuratorFrameworkFactory.builder()
                .connectString(connection_addr)
                .sessionTimeoutMs(SESSION_TIMEOUT)
                .retryPolicy(retryPolicy)
                .build();
        //3  开启连接
        cf.start();
        System.out.println("zookeeper建立连接");
        try {
            if(cf.checkExists().forPath(PARENT_NODE) == null) {
                cf.create().forPath(PARENT_NODE);
            }
            initWatch();
        } catch (Exception e) {
            System.exit(-1);
        }
    }

    public static ZookeeperClient getInstance(){
        if(CLIENT == null)
            CLIENT = new ZookeeperClient();
        return CLIENT;
    }

    /**
     * 注册监听 path
     * @param path
     * @param json
     * @param handle
     * @return  如果之前未注册过、或值不相等，则返回true，如果已经注册过、且值相等则返回false
     * @throws Exception
     */
    public boolean register(String path, String json, NodeChangeEventHandle handle) throws Exception {
        //是否创建
        boolean flag = false;
        String _path = PARENT_NODE + SEPARATOR + path;

        //先注册监听事件
        if(handle != null){
            addHandle(_path, handle);
        }

        //后 创建节点
        if(cf.checkExists().forPath(_path) == null){
            cf.create().creatingParentsIfNeeded().forPath(_path, json.getBytes());
            flag = true;
        }else{
            String data = new String(cf.getData().forPath(_path),"UTF-8");
            //如果值不相等，则覆盖
            if(data==null || !data.equals(json)){
                cf.setData().forPath(_path, json.getBytes());
                flag = true;
            }
        }

        return flag;
    }

    /**
     * 注销所有的监听器
     */
    public void unRegisterAllHandle(){
        for (Map.Entry<String, NodeChangeEventHandle>  entity  : HANDLE.entrySet()) {
            NodeChangeEventHandle value = entity.getValue();
            value.onDelete(null);
        }
        HANDLE.clear();
    }

    /**
     * 删除某一个节点，并且注销相应的监听器
     * @param path
     * @throws Exception
     */
    public void delete(String path) throws Exception {
        String _path = PARENT_NODE + SEPARATOR + path;
        if(cf.checkExists().forPath(_path) != null){
            cf.delete().deletingChildrenIfNeeded().forPath(_path);
        }
        if(HANDLE.containsKey(_path)){
            HANDLE.remove(_path);
        }
    }

    /**
     * 删除所有监听的节点，并且注销所有的监听器
     * @throws Exception
     */
    public void deleteAll() throws Exception {
        if(cf.checkExists().forPath(PARENT_NODE) != null){
            cf.delete().deletingChildrenIfNeeded().forPath(PARENT_NODE);
        }
        HANDLE.clear();
    }



    public void addHandle(String path, NodeChangeEventHandle handle){
        HANDLE.put(path, handle);
    }

    private void initWatch() throws Exception {
        //建立一个 cache缓存
        //建立一个PathChildrenCache缓存,第三个参数为是否接受节点数据内容 如果为false则不接受。 一定要设置为true
        final PathChildrenCache cache = new PathChildrenCache(cf, PARENT_NODE, true);

        //5.在初始化的时候进行缓存监听
        cache.start(PathChildrenCache.StartMode.POST_INITIALIZED_EVENT);
        cache.getListenable().addListener(new PathChildrenCacheListener() {
            /**
             * 监听子节点变更事件： 包括 新建、修改、删除
             * @param client
             * @param event
             * @throws Exception
             */
            @Override
            public void childEvent(CuratorFramework client, PathChildrenCacheEvent event) throws Exception {

                String path = event.getData().getPath();
                String data = new String(event.getData().getData(), "UTF-8");
                switch (event.getType()){
                    case CHILD_ADDED:
                        System.out.println("CHILD_ADDED : " + path + "  Data : " + data);
                        if(HANDLE.containsKey(path)){
                            HANDLE.get(path).onCreate(data);
                        }
                        break;
                    case CHILD_UPDATED:
                        System.out.println("CHILD_UPDATED : " + path + "  Data : " + data);
                        if(HANDLE.containsKey(path)){
                            HANDLE.get(path).onUpdate(data);
                        }
                        break;
                    case CHILD_REMOVED:
                        System.out.println("CHILD_REMOVED : " + path + "  Data : " + data);
                        if(HANDLE.containsKey(path)){
                            HANDLE.get(path).onDelete(data);
                        }
                        break;
                    default:
                        break;
                }
            }
        });
    }
}
