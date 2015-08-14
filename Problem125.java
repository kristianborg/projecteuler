import java.util.ArrayList;
import java.util.List;

public class Problem125 {
	
	public void solve(int maxNumDigits){
		int numResults = 0;
		long sumResults = 0;
		for (int numDigits = 1; numDigits <= maxNumDigits; numDigits++){
			List<Integer> palindromes = getPalindromes(numDigits);
			for(int palindrome : palindromes){
				if (isSquareSum(palindrome)){
					numResults++;
					sumResults+= palindrome;
					System.out.println("" + numResults + ": " +  palindrome + " is quadratic sum");
				}
			}
		}
		System.out.println("Result: " + sumResults);
	}

	
	private boolean isSquareSum(int number) {
		int minBase = 1;
		int maxBase = (int)(Math.ceil(Math.sqrt(number)));
		for(int base1 = minBase; base1 <= maxBase; base1++){
			int remainder = number - base1 * base1;
			for(int base2 = base1 + 1; base2 < maxBase; base2++){
				remainder -= base2 * base2;
				if (remainder == 0){
					return true;
				}
				if (remainder < 0){
					break;
				}
			}
			new String();
		}
		return false;
	}


	private List<Integer> getPalindromes(int numDigits) {
		int min = (int)Math.pow(10, (numDigits - 1) / 2);
		int max = (int)Math.pow(10, (numDigits - 1) / 2 + 1) - 1;
		List<Integer> result = new ArrayList<Integer>();
		for(int left = min; left <= max; left++){
			String leftString = Integer.toString(left);
			String rightString = new StringBuilder(leftString).reverse().toString();
			if (numDigits % 2 == 1){
				rightString = rightString.substring(1);
			}
			String palindrome = leftString + rightString;
			if (!result.contains(palindrome)){
				result.add(Integer.parseInt(palindrome));
			} else {
				new String();
			}
		}
		return result;
	}


	public static void main(String[] argv){
		new Problem125().solve(8);
	}
}
