package com.example.demo.Dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PunchDto {
	
	private Date checkIn;
	private Date checkOut;
	private String latitude;
	private String longitude;
	private String address;

}
