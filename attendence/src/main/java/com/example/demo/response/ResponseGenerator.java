package com.example.demo.response;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
public class ResponseGenerator {

	private static final Logger logger = Logger.getLogger(ResponseGenerator.class);
	
	public ResponseEntity<Response> successGetResponse(TransactionContext context, String message, Object object,
			HttpStatus httpStatus) {
		HttpHeaders headers = new HttpHeaders();
		headers.add("correlationId", context.getCorrelationId());
		headers.add("ApplicationLabel", context.getApplicationLabel());
		headers.add("Content-Type", "application/json");
		Response response = new Response();
		response.setData(object);
		response.setStatus("Success");
		response.setMessage(message);
		logger.debug("response class is " + Data.class);
		logger.debug("response status is " + httpStatus.toString());
		ResponseEntity<Response> responseEntity = new ResponseEntity<Response>(response, headers, httpStatus);
		return responseEntity;
	}
	
	public ResponseEntity<Response> successResponse(TransactionContext context, String message,
			HttpStatus httpStatus) {
		HttpHeaders headers = new HttpHeaders();
		headers.add("correlationId", context.getCorrelationId());
		headers.add("ApplicationLabel", context.getApplicationLabel());
		headers.add("Content-Type", "application/json");
		Response response = new Response();
		response.setStatus("Success");
		response.setMessage(message);
		logger.debug("response class is " + Data.class);
		logger.debug("response status is " + httpStatus.toString());
		ResponseEntity<Response> responseEntity = new ResponseEntity<Response>(response, headers, httpStatus);
		return responseEntity;
	}

	public ResponseEntity<Response> errorResponse(TransactionContext context, String errorMessage,
			HttpStatus httpStatus) {
		HttpHeaders headers = new HttpHeaders();
		headers.add("correlationId", context.getCorrelationId());
		headers.add("ApplicationLabel", context.getApplicationLabel());
		headers.add("Content-Type", "application/json");
		Response response = new Response();
		response.setMessage(errorMessage);
		response.setStatus("Success");
		logger.debug("response class is " + Data.class);
		logger.debug("response status is " + httpStatus.toString());
		ResponseEntity<Response> responseEntity = new ResponseEntity<Response>(response, headers, httpStatus);
		return responseEntity;
	}


	public TransactionContext generateTransationContext(HttpHeaders httpHeaders) {

		TransactionContext context = new TransactionContext();

		if (null == httpHeaders) {
			context.setCorrelationId("demo");
			context.setApplicationLabel("demo");
			return context;
		}

		if (httpHeaders.get("correlationId") != null) {
			context.setCorrelationId(httpHeaders.get("correlationId").toString());
		} else {
			context.setCorrelationId("demo");
		}
		if (httpHeaders.get("ApplicationLabel") != null) {
			context.setApplicationLabel(httpHeaders.get("ApplicationLabel").toString());
		} else {
			context.setApplicationLabel("demo");
		}
		return context;
	}

	public static ResponseEntity<Object> generateResponse(HttpStatus status, Object object, String message) {
	 
		HashMap<String, Object> map = new HashMap<>();
		map.put(message, message);
		map.put("status", "Success");
		map.put("data",object );
		return new ResponseEntity<Object>(map,status);  
	}

	public Map<Long, String> successResponse(String string, HttpStatus ok) {
		// TODO Auto-generated method stub
		return null;
	}

}
