package com.example.demo.service;

import java.util.Map;
import java.util.UUID;

import javax.validation.Valid;

import com.example.demo.Dto.LoginDto;
import com.example.demo.entity.User;

public interface AuthenticationService {

	Map<String, Object> logIn(LoginDto request);

	UUID saveUser(@Valid User request);


}
