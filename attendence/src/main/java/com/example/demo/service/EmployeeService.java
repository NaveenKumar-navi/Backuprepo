package com.example.demo.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.core.io.Resource;

import com.example.demo.Dto.EmployeeDto;
import com.example.demo.entity.Employee;


public interface EmployeeService {

	Optional<Employee> getEmployeeDetails(Long empid);

	Employee update(EmployeeDto request,Long empId);

	Employee save(@Valid Employee request);

	Employee save(EmployeeDto empDtl);

	Resource getImage(String loadedImagesUrl);

	List<Employee> findByDateAndYear(String year, String month, String day);

	Optional<Employee> findById(Long employeeId);

	Map<Long, String> findAll();

}
