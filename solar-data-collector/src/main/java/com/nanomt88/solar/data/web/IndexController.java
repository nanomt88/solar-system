package com.nanomt88.solar.data.web;

import java.util.List;

import io.netty.channel.ChannelFuture;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.nanomt88.solar.data.protocol.RequestData;
import com.nanomt88.solar.data.entity.DatCheckData;
import com.nanomt88.solar.data.main.GenerateData;
import com.nanomt88.solar.data.netty.Client;



@Controller
public class IndexController {

	@Autowired
	private GenerateData generate;
	
    @RequestMapping("/index.html")
    public ModelAndView index() throws Exception {
        ModelAndView ret = new ModelAndView();
        return ret;
    }

    @RequestMapping("/send.html")
    public void send(HttpServletRequest request, HttpServletResponse response, int count){
    	try {
    		
    		Client c = Client.getInstance();
    		ChannelFuture cf = c.getChannelFuture();
			List<DatCheckData> list = this.generate.batchAdd(count);
			for (DatCheckData datCheckData : list) {
				RequestData rd = new RequestData();
				BeanUtils.copyProperties(datCheckData, rd, new String[]{"sync"});
				cf.channel().writeAndFlush(rd);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
	
	
	
	
	
	
	
}
