package com.example.demo.entity;


import java.time.LocalDate;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "ATTENDANCE")
public class Attendance {
    
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ATTENDANCE_ID")
	private Long attendanceId;
	
	@Column(name = "CHECK_IN")
	private Date checkIn;
	
	@Column(name = "CHECK_OUT")
	private Date checkOut;
	
	@Column(name = "WORKING_HOURS")
	private int workingHours;
	
	@Column(name = "ATT_MONTH")
	private String month;
	
	@Column(name = "ATT_DATE",columnDefinition = "date")
	private LocalDate date;
	
	@Column(name = "ATT_YEAR")
	private String year;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "EMP_ID",referencedColumnName = "EMP_ID")
	private Employee employee;


}