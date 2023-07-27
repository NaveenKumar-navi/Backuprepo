package pattern;
import java.util.*;
public class lefttriangle {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
Scanner sc=new Scanner(System.in);
System.out.println("enter the number");
int n=sc.nextInt();
for(int i=n;i>=1;i--) {
	for(int j=1;j<=i;j++) {
		System.out.print("*");
	}
	System.out.println(" ");
}
	}

}
