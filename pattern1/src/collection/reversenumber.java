package collection;

public class reversenumber {

	public static void main(String[] args) {
	int a=153 ,rem,sum=0;
	while(a>0) {
		a=a%10;
		rem=a/10;
		sum=(sum*10+rem);
		

	}
	System.out.println(sum);
	}

}
