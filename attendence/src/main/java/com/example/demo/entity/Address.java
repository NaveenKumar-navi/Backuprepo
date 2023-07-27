package com.example.demo.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.example.demo.Enumeration.AddressType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "ADDRESS")
public class Address {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name="ADDRESS_ID")
	private Long addressId;
	
	@Column(name = "LOC_LAT")
	private String latitude;
	
	@Column(name = "LOC_LONG")
	private String longitude;
	
	@Column(name = "LOC_ADD")
	private String locAddress;
	
	@Column(name = "LOC_TYP" ,columnDefinition = "varchar(255)")
	private AddressType locTyp;
	
	@OneToOne
	@JoinColumn(name = "ATTENDANCE_ID",referencedColumnName = "ATTENDANCE_ID")
	private Attendance attendance;

}

