package nl.krisborg.projecteuler.problems;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Problem128 {
	
	public void solve3(){
		int numPD3s = 2; // 1 & 2 also have PD=3
		int targetNumPDs = 2000;
		
		long previousLayerBase = 2;
		long previousLayerNum = 1;
		long previousLayerSize = getLayerSize(previousLayerNum);
		
		long currentLayerBase = 8;
		long currentLayerNum = 2;
		long currentLayerSize = getLayerSize(currentLayerNum);
		long currentLayerOffset = 0;
		
		long nextLayerBase = 20;
		long nextLayerNum = 3;
		long nextLayerSize = getLayerSize(nextLayerNum);
		
		while(numPD3s < targetNumPDs){
			List<Long> neighbors = new ArrayList<Long>();
			boolean isLastOfLayer = currentLayerOffset == currentLayerSize - 1;
			boolean isFirstOfLayer = currentLayerOffset == 0;
			long currentLayerMaxDiff = currentLayerSize - 1;
			
			if (isFirstOfLayer || isLastOfLayer){
				if (PrimeHelper.isPrime(currentLayerMaxDiff)){
					boolean isCorner = currentLayerOffset == 0 || currentLayerOffset % currentLayerNum == 0;
					long value = currentLayerBase + currentLayerOffset;
					long numCorners = currentLayerOffset / currentLayerNum;
					long numNonCorners = currentLayerOffset - numCorners;
					
					long c1Offset = currentLayerOffset + 1;
					neighbors.add(mod(c1Offset, currentLayerSize) + currentLayerBase);
					long c2Offset = currentLayerOffset - 1;
					neighbors.add(mod(c2Offset, currentLayerSize) + currentLayerBase);
					
					long p1Offset = numNonCorners;
					neighbors.add(mod(p1Offset, previousLayerSize) + previousLayerBase);
					long p2Offset = -999;
					if (isCorner){
						// only one neighbor
					} else {
						p2Offset = p1Offset - 1;
						neighbors.add(mod(p2Offset, previousLayerSize) + previousLayerBase);
					}
					
					long n1Offset = numNonCorners + 2 * numCorners;
					neighbors.add(mod(n1Offset, nextLayerSize) + nextLayerBase);
					long n2Offset = n1Offset + 1;
					neighbors.add(mod(n2Offset, nextLayerSize) + nextLayerBase);
					long n3Offset = -999;
					if (isCorner){
						n3Offset = n1Offset - 1;
						neighbors.add(mod(n3Offset, nextLayerSize) + nextLayerBase);
					} else {
						// only 2 neighbors
					}
					
					List<Long> diffs = new ArrayList<Long>();
					List<Long> diffsMod6 = new ArrayList<Long>();
					long pd = 0;
					for(long neighborValue : neighbors){
						long diff = Math.abs(neighborValue - value);
						diffs.add(diff);
						diffsMod6.add(diff%6);
						if (PrimeHelper.isPrime(diff)){
							pd++;
						}
					}
					if (pd == 3){
						numPD3s++;
						System.out.println("" + numPD3s + ": " + value);
					}
					
				} else {
					// for the first and the last item, the diffs will be
					// [1, x, even, uneven, even, uneven] where 
					// x = [layerNumber * 6] - 1.
					// So only when x is prime it is possible to get 3 primes
				}
			} else {
				// for all but the first, and the last item, the diffs will be
				// [1, 1, even, uneven, even, uneven]
				// in other words: two ones and two even numbers
				// so impossible to get 3 primes
			}
			
			if (isLastOfLayer){
				// going to next layer; update all layer-related parameters
				previousLayerBase = currentLayerBase;
				previousLayerNum = currentLayerNum;
				previousLayerSize = currentLayerSize;
				
				currentLayerBase = nextLayerBase;
				currentLayerNum = nextLayerNum;
				currentLayerSize = nextLayerSize;
				currentLayerOffset = 0;
				
				nextLayerBase = currentLayerBase + currentLayerNum * 6;
				nextLayerNum = currentLayerNum + 1;
				nextLayerSize = getLayerSize(nextLayerNum);
			} else {
				currentLayerOffset = currentLayerSize - 1;
			}
		}
	}
	
	private long getLayerSize(long layerNum) {
		return layerNum * 6;
	}
	
	public long mod(long num, long mod){
		return (num % mod + mod) % mod; 
	}
	
	public static void main(String[] argv){
		long before = System.currentTimeMillis();
		new Problem128().solve3();
		long time = System.currentTimeMillis() - before;
		System.out.println("Took " + time + "ms");
	}

	static class PrimeHelper {
		
		private static int maxPrime = 1000;
		private static Set<Long> primeValues = new HashSet<Long>();
		static {
			fillSieve();
		}
		
		public static void fillSieve() {
			boolean[] primes = new boolean[maxPrime];
			primeValues.clear();
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
		    		primeValues.add((long)i);
		    	}
		    }
		}
		
		public static boolean isPrime(long num){
			if (num >= maxPrime){
				maxPrime *= 2;
				fillSieve();
			}
			return primeValues.contains(num);
		}
	}
}
