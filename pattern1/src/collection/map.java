package collection;
import java.util.*;
public class map {

	public static void main(String[] args) {
	HashMap<Integer,String> map=new HashMap<Integer,String>();
	map.put(1,"java");
	map.put(2, "html");
    map.put(3, "css");
    map.put(4, "javascript");
    System.out.println(map);
    System.out.println(map.values());
    HashMap<Integer,String> map1=new HashMap<Integer,String>();
    
    map1.put(5, "ajax");
    map1.put(6, "jquery");
    map1.putAll(map);
    
    System.out.println(map1);
    
    for(Map.Entry m:map1.entrySet()) {
    	System.out.println(m.getKey());
    }
    
    
	}

}
