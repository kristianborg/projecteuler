package nl.krisborg.projecteuler.problems;

import java.math.BigInteger;

public class Problem120 {
	
	public void solve(){
		int sum = 0;
		for (int a = 3; a <= 1000; a++){
			int rMax = getRMax(a);
			System.out.println("" + a + ": " + rMax);
			sum += rMax;
		}
		System.out.println("Result: " + sum);
	}
	
	public int getRMax(int a){
		BigInteger a1 = BigInteger.valueOf(a - 1);
		BigInteger a2 = BigInteger.valueOf(a + 1);
		BigInteger mod = BigInteger.valueOf(a * a);
		int maxExp = a * 2; // don't know why, but it seems after at most a*2 the results start to repeat
		int maxResult = 0;
		for(int exp = 1; exp <= maxExp; exp++){
			BigInteger expBI = BigInteger.valueOf(exp);
			BigInteger pow1 = a1.modPow(expBI, mod);
			BigInteger pow2 = a2.modPow(expBI, mod);
			int result = pow1.add(pow2).mod(mod).intValue();
			if (result > maxResult){
				maxResult = result;
			}
		}
		return maxResult;
	}
	
	public static void main(String[] argv){
		long before = System.currentTimeMillis();
		new Problem120().solve();
		long time = System.currentTimeMillis() - before;
		System.out.println("took " + time + "ms");
	}

}
