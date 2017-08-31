package com.nanomt88.solar.listener;

import org.springframework.beans.BeansException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ApplicationFactory implements ApplicationContextAware {
	private static ApplicationContext ctx = null;

	/**
	 * 获取Spring配置环境
	 * @return ApplicationContext
	 */
	public static ApplicationContext getContext() {
		if (ctx == null) {
			ctx = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		}
		return ctx;
	}
	
	public void setApplicationContext(ApplicationContext context)
			throws BeansException {
		ctx = context;
	}
}
