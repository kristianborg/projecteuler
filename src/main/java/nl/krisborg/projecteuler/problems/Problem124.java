package nl.krisborg.projecteuler.problems;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Problem124 {

	public void solve(int max, int target){
		List<Integer> primes = createPrimes(max);
		List<NRadNPair> pairs = new ArrayList<NRadNPair>();
		for(int n = 1; n <= max; n++){
			List<Integer> primeFactors = factorize(n, primes);
			int radN = multiply(primeFactors);
			NRadNPair pair = new NRadNPair(n, radN);
			pairs.add(pair);
		}
		Collections.sort(pairs);
		for(int k = 0; k < pairs.size(); k++){
			NRadNPair pair = pairs.get(k);
		}
		System.out.println("Result: " + pairs.get(target - 1).n);
	}
	
	private int multiply(List<Integer> numbers) {
		int result = 1;
		for(int num : numbers){
			result *= num;
		}
		return result;
	}

	private List<Integer> factorize(int i, List<Integer> primes) {
		List<Integer> result = new ArrayList<Integer>();
		for(int prime : primes){
			if (i == 1){
				break;
			}
			if (i % prime == 0){
				result.add(prime);
				while (i % prime == 0){
					i /= prime;
				}
			}
		}
		return result;
	}

	private List<Integer> createPrimes(int max) {
		boolean[] primes = new boolean[max];
		List<Integer> result = new ArrayList<Integer>();
	    Arrays.fill(primes, true);
	    primes[0] = primes[1] = false;
	    for (int i = 2; i < primes.length; i++) {
	        if(primes[i]) {
	            for (int j = 2; i * j <primes.length; j++) {
	                primes[i*j]=false;
	            }
	        }
	    }
	    for(int i = 2; i < primes.length; i++){
	    	if (primes[i]){
	    		result.add(i);
	    	}
	    }
		return result;
	}
	
	public static void main(String[] argv){
		new Problem124().solve(100000, 10000);
	}
	
	class NRadNPair implements Comparable<NRadNPair> {
		public int n;
		public int radN;
		
		public NRadNPair(int n, int radN){
			this.n = n;
			this.radN = radN;
		}

		public int compareTo(NRadNPair o) {
			if (radN == o.radN){
				return n - o.n;
			} else {
				return radN - o.radN;
			}
		}
	}
}
