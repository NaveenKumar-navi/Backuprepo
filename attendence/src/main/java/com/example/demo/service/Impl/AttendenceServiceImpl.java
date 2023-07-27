package com.example.demo.service.Impl;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Dto.AttendanceListDto;
import com.example.demo.Dto.EmployeeAttendanceDto;
import com.example.demo.Dto.PunchDto;
import com.example.demo.Enumeration.AddressType;
import com.example.demo.Utils.DateToTime;
import com.example.demo.entity.Address;
import com.example.demo.entity.Attendance;
import com.example.demo.entity.Employee;
import com.example.demo.repository.AddressRepository;
import com.example.demo.repository.AttendenceRepository;
import com.example.demo.repository.EmployeeRepository;
import com.example.demo.service.AttendenceService;

@Service
public class AttendenceServiceImpl implements AttendenceService{
	
	@Autowired
	private AttendenceRepository attendenceRepository;
	
	@Autowired
	private EmployeeRepository employeeRepository;
	
	@Autowired
	private AddressRepository addressRepository;
	
	
	private AddressType addressType;
	

	@Override
	public EmployeeAttendanceDto attendenceCheckIn(PunchDto request ,Long empId) {
		
		//Optional<Attendance> attData = attendenceRepository.findByEmployeeEmployeeId(empId);
		 Optional<Employee> empData = employeeRepository.findById(empId);
		 Employee emp = empData.get();
		 Date date = new Date();
		 LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Attendance attdata = Attendance.builder()
				.checkIn(request.getCheckIn())
				.employee(emp)
				.date(localDate)
				.build();
		Attendance save = attendenceRepository.save(attdata);
		
		Address address = Address.builder()
				.latitude(request.getLatitude())
				.longitude(request.getLongitude())
				.locAddress(request.getAddress())
				.locTyp(addressType.IN)
				.attendance(save)
				.build();
		addressRepository.save(address);
		EmployeeAttendanceDto empAttData = new EmployeeAttendanceDto();
		empAttData.setCheckIn(save.getCheckIn().toString());

		return empAttData;
	}



	@Override
	public EmployeeAttendanceDto attendenceCheckOut(PunchDto request,Long empId){
		
		Date date = new Date();
		EmployeeAttendanceDto empAttData = new EmployeeAttendanceDto();
		 try {
	        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		Attendance attData = attendenceRepository.findByEmployeeEmployeeIdAndDate(empId,localDate);
		DateToTime datetoTime = new DateToTime();
		attData.setCheckOut(request.getCheckOut());
		int startTime = datetoTime.getHourFromDate(attData.getCheckIn());
		int endTime = datetoTime.getHourFromDate(date);
		attData.setWorkingHours(endTime-startTime);
		
		Attendance employeeAttendanceData = attendenceRepository.save(attData);
		empAttData.setCheckIn(employeeAttendanceData.getCheckIn().toString());
		empAttData.setCheckOut(employeeAttendanceData.getCheckOut().toString());
		empAttData.setWorkingHours(employeeAttendanceData.getWorkingHours());
		
		 } catch (Exception e) {
	            e.printStackTrace();
	        }
		return empAttData;
	}
	
	@Override
	public List<EmployeeAttendanceDto>getCheckInData(AttendanceListDto request,Long empId) {
		String month,year;
		month = request.getMonth();
		year = request.getYear();
		
		List<Attendance>empCheckInNdCheckOutData = attendenceRepository.findByEmployeeEmployeeIdAndMonthAndYear(empId,month,year);
		List<EmployeeAttendanceDto> attendanceList = new ArrayList<>();
		for(Attendance attendList :empCheckInNdCheckOutData) {
			EmployeeAttendanceDto EmployeeAttendanceDto =  new EmployeeAttendanceDto();
			EmployeeAttendanceDto.setCheckIn(attendList.getCheckIn().toString());
			EmployeeAttendanceDto.setCheckOut(attendList.getCheckOut().toString());
			EmployeeAttendanceDto.setWorkingHours(attendList.getWorkingHours());
			attendanceList.add(EmployeeAttendanceDto);
		}
		return attendanceList;
	}


	@Override
	public List<Attendance> findByEmployeeEmployeeIdAndMonthAndYear(Long empId, String month, String year) {
		return attendenceRepository.findByEmployeeEmployeeIdAndMonthAndYear(empId,month,year);
	}

}
