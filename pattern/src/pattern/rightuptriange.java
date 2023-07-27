package pattern;
import java.util.*;
public class rightuptriange {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		System.out.println("enter the number");
		int n=sc.nextInt();
		for(int i=n;i>=1;i--) {
			for(int j=1;j<=n;j++) {
				if(i<=j||j==i) {
					System.out.print("*");
				}
				else {
					System.out.print(" ");
				}
			}
			System.out.println(" ");
		}

	}

}
