package com.example.demo.Dto;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Data
public class LoginDto {
	
	@NotBlank(message = "Password is required!")
	private String password;

	@NotBlank(message = "userName is required")
	private String userName;
}