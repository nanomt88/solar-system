package com.nanomt88.solar.mapper;

import java.util.List;

import com.nanomt88.solar.entity.User;


public interface UserMapper {

    User selectByPrimaryKey(String id);

    List<User> findAll() ;
}