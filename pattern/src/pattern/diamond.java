package pattern;
import java.util.*;
public class diamond {

	public static void main(String[] args) {
    Scanner sc=new Scanner(System.in);
    System.out.println("enter the value");
    int n=sc.nextInt();
    for(int i=n;i>=1;i--) {
    	for(int j=1;j<=n;j++) {
    		if(i<=j||j==i) {
    			System.out.print(" *");
    		}
    		else {
    			System.out.print(" ");
    		}
    	}
    	System.out.println(" ");
    }
    for(int i=1;i<=n;i++) {
    	for(int j=1;j<=n;j++) {
    		if(i<=j||j==i) {
    			System.out.print(" *");
    		}
    		else {
    			System.out.print(" ");
    		}
    	}
    	System.out.println(" ");
    }

	}

}
