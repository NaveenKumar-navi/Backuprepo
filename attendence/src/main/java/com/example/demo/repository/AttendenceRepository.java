package com.example.demo.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.Attendance;

@Repository
public interface AttendenceRepository  extends JpaRepository<Attendance, Long> {

	List<Attendance> findByEmployeeEmployeeIdAndMonthAndYear(Long empId,String month, String year);

	Optional<Attendance> findByEmployeeEmployeeId(Long employeeId);

	Attendance findByEmployeeEmployeeIdAndDate(Long empId, LocalDate date);
}
