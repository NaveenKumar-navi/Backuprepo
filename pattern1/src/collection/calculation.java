package collection;
import java.util.*;
public class calculation {

	public static void main(String[] args) {
    HashMap<Integer,String> map=new HashMap<Integer,String>();	
    map.put(1, "num");
    map.put(2,"num1");
    map.put(3, "num3");
    
    System.out.println(map.values());
    
   String[] s={"jayaram"};
   Set<String>ss=new HashSet<String>(Arrays.asList(s));
   System.out.println(ss);

}
}