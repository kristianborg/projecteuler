package nl.krisborg.projecteuler.problems;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class Problem146 {

  private static final int LOW_CERTAINTY = 4;
  private static final int HIGH_CERTAINTY = 1000;
  private List<Integer> xValues = List.of(1, 3, 7, 9, 13, 27);

  public static void main(String[] args) {
    long before = System.currentTimeMillis();
    new Problem146().solve(150_000_000);
    long time = System.currentTimeMillis() - before;
    System.out.printf("Took: %sms%n", time);
  }

  private void solve(int maxValue) {
    long result = 0;
    for (int i = 2; i <= maxValue; i++) {

      // for all odd numbers n^2+1 is even and thus not prime, so we can skip those.
      if (i%2 == 1) {
        continue;
      }

      // for multiples of 5 +/- 1 we have n^2 + 9 is divisible by 5, so we can skip those
      // for multiples of 5 +/- 3 we have n^2 + 1 is divisible by 5, so we can skip those
      // that leaves only multiples of 5 as valid candidates
      if (i % 5 != 0) {
        continue;
      }

      // for multiples of 7 +/- 1 we have n^2 + 13 is divisible by 7, so we skip those
      // for multiples of 7 +/- 5 we have n^2 + 3 is divisible by 7, so we skip those
      int iMod7 = i % 7;
      if (iMod7 == 1 || iMod7 == 6 || iMod7 == 5 || iMod7 == 2) {
        continue;
      }

      // for multiples of 9 +/- 3 we have n^2 + 9 is divisible by 9, so we skip those
      int iMod9 = i % 9;
      if (iMod9 == 3 || iMod9 == 6) {
        continue;
      }

      // for multiples of 11 +/- 3 we have n^2 + 13 is divisible by 11, so we skip those
      // for multiples of 11 +/- 9 we have n^2 + 7 is divisible by 11, so we skip those
      int iMod11 = i % 11;
      if (iMod11 == 3 || iMod11 == 8 || iMod11 == 9 || iMod11 == 2) {
        continue;
      }

      // for multiples of 13 +/- 5 we have n^2 + 1 is divisible by 13, so we skip those
      // for multiples of 13 +/- 7 we have n^2 + 3 is divisible by 13, so we skip those
      // for multiples of 13 +/- 11 we have n^2 + 9 is divisible by 13, so we skip those
      int iMod13 = i % 13;
      if (iMod13 == 5 || iMod13 == 7 || iMod13 == 11 || iMod13 == 8 || iMod13 == 6 || iMod13 == 2) {
        continue;
      }

      if (test(i, LOW_CERTAINTY) && test(i, HIGH_CERTAINTY)) {
        System.out.printf("found: %s%n", i);
        result += i;
      }
    }
    System.out.printf("Result for %s: %s%n", maxValue, result);
  }

  private boolean test(int n, int certainty) {
    BigInteger nSquare = BigInteger.valueOf(n).pow(2);
    List<BigInteger> primes = new ArrayList<>();
    for (Integer xValue : xValues) {
      BigInteger number = nSquare.add(BigInteger.valueOf(xValue));
      if (!number.isProbablePrime(certainty)) {
        return false;
      } else {
        primes.add(number);
      }
    }

    if (isConsecutivePrimes(primes)) {
      return true;
    } else {
      System.out.printf("%s failed because it resulted in primes, but they were not consecutive%n", n);
      return false;
    }
  }

  private boolean isConsecutivePrimes(List<BigInteger> primes) {
    List<BigInteger> consecutivePrimes = new ArrayList<>();;
    consecutivePrimes.add(primes.get(0));
    BigInteger primeCandidate = primes.get(0);
    while (consecutivePrimes.size() < primes.size()) {
      primeCandidate = primeCandidate.add(BigInteger.valueOf(2));
      if (primeCandidate.isProbablePrime(HIGH_CERTAINTY)) {
        consecutivePrimes.add(primeCandidate);
      }
    }
    return primes.equals(consecutivePrimes);
  }
}
