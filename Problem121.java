import java.util.ArrayList;
import java.util.List;

public class Problem121 {
	
	public void run(int numGames){
		int minWins = (numGames / 2) + 1;
		int maxLosses = numGames - minWins;
		long denominator = factorial(numGames + 1);
		long numerator  = 0;
		for (int i = 0; i <= maxLosses; i++){
			numerator += sumAllCombinations(numGames, i);
		}
		long prize = denominator / numerator;
		System.out.println("Playing " + numGames + " games " + " gives a win chance of " + numerator + "/" + denominator + " resulting in a prize of " + prize);
	}
	
	private long sumAllCombinations(int maxValue, int numItems) {
		List<Integer>  combinations = getAllCombinationSums(1, maxValue, numItems, 1);
		long result = 0;
		for(int sum : combinations){
			result += sum;
		}
		return result;
	}
	
	private List<Integer> getAllCombinationSums(int minValue, int maxValue, int numItems, int productSoFar){
		List<Integer> result = new ArrayList<Integer>();
		if (numItems == 0){
			result.add(productSoFar);
		} else if (maxValue - minValue + 1 >= numItems){
			for (int i = minValue; i <= maxValue; i++){
				List<Integer> subResult = getAllCombinationSums(i + 1, maxValue, numItems - 1, productSoFar * i);
				result.addAll(subResult);
			}
		}
		return result;
	}

	private long factorial(int n) {
		long result = 1;
		for (int i = 1; i <= n; i++){
			result *= i;
		}
		return result;
	}

	public static void main(String[] argv){
		Problem121 p = new Problem121();
		for (int i = 4; i <= 15; i++){
			p.run(i);
		}
	}
}
