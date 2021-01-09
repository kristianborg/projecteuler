package nl.krisborg.projecteuler.problems;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Problem123 {
	
	public void solve(long target){
		int min = (int)Math.sqrt(target);
		int max = min * 10;
		List<Integer> primes = createPrimes(max);
		for (int n = 1; n <= primes.size(); n++){
			int prime = primes.get(n - 1);
			if (prime >= min){
				BigInteger exponent = BigInteger.valueOf(n);
				BigInteger mod = BigInteger.valueOf(prime).pow(2);
				BigInteger val1 = BigInteger.valueOf(prime - 1);
				BigInteger val2 = BigInteger.valueOf(prime + 1);
				BigInteger modPow1 = val1.modPow(exponent, mod);
				BigInteger modPow2 = val2.modPow(exponent, mod);
				BigInteger result = modPow1.add(modPow2).mod(mod);
				if (result.longValue() >= target){
					System.out.println("Result: n=" + n + " prime=" + prime + " remainder=" + result.longValue());
					return;
				}
			}
		}
		
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
		new Problem123().solve(10000000000L);
	}

}
