package com.example.demo.Utils;


import java.util.Calendar;
import java.util.Date;

public class DateToTime {
	
	public int getHourFromDate(Date givenDate) {
	
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(givenDate);
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        return hour;
    }
	
}
