package nl.krisborg.projecteuler.lib;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

public abstract class PrimeHelper {

  private static int lastPrime = 0;
  private static List<Integer> primes;

  public static List<Integer> getPrimeFactors(long x) {
    if (primes == null) {
      populatePrimes(10000);
    }

    int primePointer = 0;
    List<Integer> result = new ArrayList<>();
    while(true) {
      if (primePointer == primes.size()) {
        populatePrimes(lastPrime * 2);
      }
      int prime = primes.get(primePointer);
      while(x % prime == 0) {
        x /= prime;
        result.add(prime);
      }
      if (x == 1) {
        break;
      }
      primePointer++;
    }
    return result;
  }

  private static void populatePrimes(int maxPrime) {
    primes = getPrimes(maxPrime);
    lastPrime = primes.get(primes.size() - 1);
  }

  public static long getGcd(long x, long y) {
    if (x < y) {
      throw new RuntimeException("x should be larger than y");
    } else if (y == 0) {
      return x;
    } else {
      return getGcd(y, x % y);
    }
  }

  public static List<Integer> getPrimes(int max) {
    if (max < 2) {
      return new ArrayList<>();
    }
    max = max + 1; // array is zero-based, and we want result to include `max`
    boolean[] isNotPrime = new boolean[max];
    isNotPrime[0] = true;
    isNotPrime[1] = true;
    for (int i = 2; i <= Math.sqrt(max); i++) {
      if (!isNotPrime[i]) {
        for (int j = i * 2; j < max; j += i) {
          isNotPrime[j] = true;
        }
      }
    }
    List<Integer> result = new ArrayList<>();
    for (int i = 0; i < isNotPrime.length; i++) {
      if (!isNotPrime[i]) {
        result.add(i);
      }
    }
    return result;
  }

  // See: https://www.geeksforgeeks.org/euclidean-algorithms-basic-and-extended/
  public static EUAResult extendedEuclideanAlgorithm(long a, long b) {
    if (a == 0) {
      return new EUAResult(b, 0, 1);
    }

    EUAResult subResult = extendedEuclideanAlgorithm(b % a, a);
    return new EUAResult(
        subResult.getGcd(),
        subResult.getY() - (b / a) * subResult.getX(),
        subResult.getX()
    );
  }

  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class EUAResult {
    private long gcd;
    private long x;
    private long y;
  }
}
