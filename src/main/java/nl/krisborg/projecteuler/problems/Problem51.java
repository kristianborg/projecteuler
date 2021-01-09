package nl.krisborg.projecteuler.problems;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


public class Problem51 {
	
	boolean[] primes;
	
	public void run(int maxPrime, int target){
		initPrimes(maxPrime);
		Set<List<Integer>> results = new HashSet<List<Integer>>();
		for(int i = 10; i < maxPrime; i++){
			if (!primes[i]){
				continue;
			}
			String prime = Integer.toString(i);
			int primeLength = prime.length();
			
			
			for (int numPermutations = 1; numPermutations < primeLength; numPermutations++){
			
				HashSet<HashSet<Integer>> premutations = getPermutationPositions(primeLength, numPermutations, null);
				for(HashSet<Integer> permutation : premutations){
					List<Integer> primes = getPrimes(prime, permutation);
					if (primes.size() >= target){
						List<Integer> primesOfUnequalLength = new ArrayList<Integer>();
						for(int resultPrime : primes){
							if (Integer.toString(resultPrime).length() != primeLength){
								primesOfUnequalLength.add(resultPrime);
							}
						}
						primes.removeAll(primesOfUnequalLength);
						
						if (primes.size() >= target){
							results.add(primes);
							System.out.println("prime=" + prime + ", permutation=" + permutation + ", primes=" + primes);
						}
					}
				}
			}
		}
		
		for(List<Integer> result : results){
			System.out.println(result + " - " + result.size());
		}
	}
	
	private List<Integer> getPrimes(String prime, Set<Integer> permutations){
		List<Integer> result = new ArrayList<Integer>();
		for (int i = 0; i <= 9; i++){
			int primeCandidate = getPrimeReplacement(prime, permutations, i);
			if (primes[primeCandidate]){
				result.add(primeCandidate);
			}
		}
		return result;
	}
	
	private int getPrimeReplacement(String prime, Set<Integer> permutations, int replacement){
		char[] characters = prime.toCharArray();
		for(int i = 0; i < characters.length; i++){
			if (permutations.contains(i)){
				characters[i] = Character.toChars(replacement + 48)[0];
			}
		}
		return Integer.parseInt(new String(characters));
	}
	
	private HashSet<HashSet<Integer>> getPermutationPositions(int length, int chose, HashSet<HashSet<Integer>> partialResults){
		HashSet<HashSet<Integer>> result = new HashSet<HashSet<Integer>>();
		if (partialResults == null){
			for (int i = 0; i < length; i++){
				HashSet<Integer> list = new HashSet<Integer>();
				list.add(i);
				result.add(list);
			}
		} else {
			for (HashSet<Integer> partialResult: partialResults){
				for(int i = 0; i < length; i++){
					if (!partialResult.contains(i)){
						HashSet<Integer> newPartialResult = (HashSet<Integer>)partialResult.clone();
						newPartialResult.add(i);
						result.add(newPartialResult);
					}
				}
			}
		}
		
		if (chose < 2){
			return result;
		} else {
			return getPermutationPositions(length, chose - 1, result);
		}
	}
	
	private void initPrimes(int max){
		max += 1;
		primes = new boolean[max];
		primes[0] = false;
		primes[1] = false;
		for(int i = 2; i < primes.length; i++){
			primes[i] = true;
		}
		
		for(int i = 2; i < primes.length; i++){
			if (!primes[i]){
				continue;
			}
			for (int j = i * 2; j < primes.length; j+= i){
				primes[j] = false;
			}
		}
	}
	

	public static void main(String[] argv){
		// new Problem51().run(99, 6);
		// new Problem51().run(99999, 7);
		new Problem51().run(999999, 8);
	}
}
