import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Problem119 {
	
	public void solve(int target){
		int numSolutions = 0;
		List<Long> candidates = getCandidates2(500000000000000L);
		for(long candidate : candidates){
			long digitSum = getDigitSum(candidate);
			if (isPow(candidate, digitSum)){
				numSolutions++;
				System.out.println("" + numSolutions + ": "+ candidate + "=" + digitSum + "^?");
				if (numSolutions == 30){
					System.out.println("Found result: " + candidate);
				}
			}
		}
	}
	
	private boolean isPow(long pow, long base) {
		long result = 1;
		if (base <= 1){
			return false;
		}
		while(true){
			if (result == pow){
				return true;
			}
			if (result > pow){
				return false;
			}
			result *= base;
		}
	}

	private long getDigitSum(long candidate) {
		char[] chars = Long.toString(candidate).toCharArray();
		long result = 0;
		for(char c : chars){
			result += c - 48;
		}
		return result;
	}

	public static void main(String[] argv){
		long before = System.currentTimeMillis();
		new Problem119().solve(2);
		long time = System.currentTimeMillis() - before;
		System.out.println("took " + time + "ms");
	}
	
	public List<Long> getCandidates2(long maxResult){
		long minBase = 2;
		long maxBase = (long)Math.sqrt(maxResult);
		Set<Long> resultSet = new HashSet<Long>();
		System.out.println("Collection candidates");
		for (long base = minBase; base <= maxBase; base++){
			for(long exp = 2;;exp++){
				long pow = (long)Math.pow((double)base, (double)exp);
				if (pow > maxResult){
					break;
				}
				if (pow >= 10){
					resultSet.add(pow);
				}
			}
		}
		
		System.out.println("Sorting candidates");
		ArrayList<Long> result = new ArrayList<Long>(resultSet);
		Collections.sort(result);
		return result;
	}
}
