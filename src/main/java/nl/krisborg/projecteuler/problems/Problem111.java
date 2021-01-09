package nl.krisborg.projecteuler.problems;

public class Problem111 {
	
	private static final int MAX_ARRAY_SIZE = 1000000000;

	private void run(int numDigits){
		long before = System.currentTimeMillis();
		solve(numDigits);
		System.out.println("Solved in " + (System.currentTimeMillis() - before) + "ms");
	}
	
	private void solve(int numDigits){
		long maxPrime = (long)Math.pow(10, numDigits) - 1;
		long minPrime = (long)Math.pow(10, numDigits - 1);
		int arraySize = (int)Math.min(maxPrime, MAX_ARRAY_SIZE);
		long iterations = maxPrime / arraySize;
		if (iterations * arraySize < maxPrime){
			iterations++;
		}
		long[] primes = new long[(int)((maxPrime / Math.log(maxPrime)) * 1.2)];
        int numPrimes = 0;
        System.out.println("Calculating primes untill " + maxPrime);
		for (long iteration = 0; iteration < iterations; iteration++){
			System.out.println("processing iteration " + (iteration + 1) + "/" + iterations);
			long offset = iteration * arraySize;
			boolean[] subsetPrimes = createArray(arraySize);
			if (iteration == 0){
				subsetPrimes[0] = false;
				subsetPrimes[1] = false;
			}
			for(long prime : primes){
				if (prime == 0){
					break;
				}
				long startPoint = offset / prime;
				if (startPoint * prime < offset){
					startPoint++;
				}
				long endPoint = (offset + arraySize) / prime;
				if (endPoint * prime >= offset + arraySize){
					endPoint--;
				}
				for (long i = startPoint; i <= endPoint; i++){
					subsetPrimes[(int)((prime * i) % arraySize)] = false;
				}
			}
			
			for(long i = 0; i < arraySize; i++){
				if (subsetPrimes[(int)i]){
					long prime = (iteration * arraySize) + i;
					if (prime * 2 > offset + arraySize){
						break;
					}
					for(long j = prime * 2;j < offset + arraySize; j += prime){
						subsetPrimes[(int)(j % arraySize)] = false;
					}
				}
			}
			
			for(long i = 0; i < arraySize; i++){
				if (subsetPrimes[(int)i]){
					primes[numPrimes] = i + offset;
					numPrimes++;
				}
			}
		}
		System.out.println("Found " + numPrimes + " primes");
		
		int[] maxCharOccurences = new int[10];
		for (int i = 0; i < numPrimes; i++){
			long prime = primes[i];
			if (prime < minPrime){
				continue;
			}
			int[] charOccurences = getCharOccurences(prime);
			for(int j = 0; j < 10; j++){
				if (maxCharOccurences[j] < charOccurences[j]){
					maxCharOccurences[j]= charOccurences[j];
				}
			}
		}
		
		System.out.println();
		for(int i = 0; i < 10; i++){
			System.out.println("M(" + numDigits + "," + i + ") = " + maxCharOccurences[i]);
		}
		
		long[] sumMaxOccurence = new long[10];
		for (int i = 0; i < numPrimes; i++){
			long prime = primes[i];
			if (prime < minPrime){
				continue;
			}
			int[] charOccurences = getCharOccurences(prime);
			for(int j = 0; j < 10; j++){
				if (charOccurences[j] == maxCharOccurences[j]){
					sumMaxOccurence[j] += prime;
				}
			}
		}
		System.out.println();
		for(int i = 0; i < 10; i++){
			System.out.println("S(" + numDigits + "," + i + ") = " + sumMaxOccurence[i]);
		}
		
		long sum = 0;
		for (long i : sumMaxOccurence){
			sum+= i;
		}
		System.out.println();
		System.out.println("Result: " + sum);
	}

	private int[] getCharOccurences(long number) {
		int[] result = new int[10];
		String numberString = Long.toString(number);
		char[] numberChars = numberString.toCharArray();
		for (char c : numberChars){
			result[c - '0']++;
		}
		return result;
	}

	private boolean[] createArray(int size){
		boolean[] result = new boolean[size];
		for (int i = 0; i < size; i++){
			result[i] = true;
		}
		return result;
	}
	
	public static void main(String[] argv){
		new Problem111().run(Integer.parseInt(argv[0]));
	}
}
