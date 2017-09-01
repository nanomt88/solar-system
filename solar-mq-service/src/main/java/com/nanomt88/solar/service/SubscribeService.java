package com.nanomt88.solar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nanomt88.solar.entity.Subscribe;
import com.nanomt88.solar.mapper.SubscribeMapper;

@Service("subscribeService")
public class SubscribeService {

	@Autowired
	private SubscribeMapper subscribeMapper;

	public SubscribeMapper getSubscribeMapper() {
		return subscribeMapper;
	}

	@Autowired
	public void setSubscribeMapper(SubscribeMapper subscribeMapper) {
		this.subscribeMapper = subscribeMapper;
	}
	
	public List<Subscribe> findAllSubscribe(){
		return this.subscribeMapper.findAllSubscribe();
	}
	
	
}
