package com.nanomt88.solar.listener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

/**
 * @author nanomt88@gmail.com
 * @create 2017-09-03 18:44
 **/
@PropertySource("classpath:*.properties")
public class EnvironmentUtil {

    @Autowired
    private static Environment environment;

    public static void setEnvironment(Environment env){
        environment = env;
    }

    public static String getProperty(String key){
        return environment.getProperty(key);
    }
}
