package nl.krisborg.projecteuler.problems;


import nl.krisborg.projecteuler.lib.PrimeHelper;

import java.util.List;

public class Problem134 {

  public long run(int minPrime, int maxPrime) {
    long before = System.currentTimeMillis();

    // we want the first prime AFTER maxPrime, so we get a bit more primes
    List<Integer> primes = PrimeHelper.getPrimes((int)(maxPrime * 1.1));
    long result = 0;
    for (int i = 0; i < primes.size() - 1; i++) {
      int p1 = primes.get(i);
      int p2 = primes.get(i + 1);
      if (p1 < minPrime) {
        continue;
      }
      if (p1 > maxPrime) {
        break;
      }

      long subResult = getNumberWhereLastDigitsAreP1AndDivisibleByP2(p1, p2);
      //System.out.printf("%s/%s: %s\r\n", p1, p2, subResult);
      result += subResult;
    }
    long time = System.currentTimeMillis() - before;
    System.out.printf("Result for %s <= p1 <= %s: %s (took %sms)\r\n", minPrime, maxPrime, result, time);
    return result;
  }


  private long getNumberWhereLastDigitsAreP1AndDivisibleByP2_naive(int p1, int p2) {
    for (int attempt = 0; true; attempt++) {
      long numberWhereLastDigitsAreP1 = Long.parseLong("" + attempt + p1);
      if (numberWhereLastDigitsAreP1 % p2 == 0) {
        return numberWhereLastDigitsAreP1;
      }
    }
  }

  /*
   * Theorem 1:
   *    When n is a prime number then it is valid to divide by any non-zeronumber.
   *    That is, for each a ∈ {1,2, ..., n−1} there is one, and only one, number u ∈ {1,2, ..., n−1} such that au = 1  (mod n).
   *    Then, dividing by a is the same as mulitplying by u.
   *    We call u the multiplicative inverse of ‘a’ under ‘m’.
   * Theorem 2:
   *    The idea is to use Extended Euclidean algorithms that takes two integers ‘a’ and ‘b’, finds their gcd and also find ‘x’ and ‘y’ such that ax + by = gcd(a, b)
   *    To find multiplicative inverse of ‘a’ under ‘m’, we put b = m in above formula. Since we know that a and m are relatively prime, we can put value of gcd as 1:
   *    - ax + my = 1
   *    - ax + my ≅ 1 (mod m)
   *    - ax  ≅ 1 (mod m)
   *   So the ‘x’ that we can find using Extended Euclid Algorithm is the multiplicative inverse of ‘a’
   *
   * For the case p1=19, p2=23:
   * 1. (19 + (100 * x)) % 23 = 0
   * 2. (19 + (8 * x)) % 23 = 0
   * 3. (8 * x) % 23 = -19
   * 4. (8 * x) % 23 = 4
   * 5. x % 23 = (4 / 8) % 23
   * 6. using theorem 1 & 2 to figure out The multiplicative inverse of 8 under 23:
   *    extended_euclidean_algorithm(8, 23) = [gcd=1, coefficient1=-1, coefficient2=3]
   *    so u = 3
   * 7. x % 23 = (4 * 3) % 23
   * 8. x = 12
   * 9. solution: 19 + 100 * 12 = 1219.
   *
   * For the generic case:
   * 1. The step-size (100) from step 1 & 9 depends on the size of p1. It's exact value is 10 ^  [# digits in p1]
   * 2. The numerator (4) from the calucalation (4 / 8) comes from p2 - p1
   * 3. The denominator (8) from the calucalation (4 / 8) comes from 100 % 23
   * 4. solve x for (p1 + (step-size * x)) % p2 = 0
   * 5. then result = p1 + x * stepSize
   *
   * Sources:
   * - https://www.maths.ox.ac.uk/system/files/attachments/lecture2.pdf
   * - https://www.geeksforgeeks.org/multiplicative-inverse-under-modulo-m/
   * - https://www.geeksforgeeks.org/euclidean-algorithms-basic-and-extended/
   */
  private long getNumberWhereLastDigitsAreP1AndDivisibleByP2(long p1, long p2) {
    long stepSize = (long)Math.pow(10, Long.toString(p1).length());
    long numerator = p2 - p1;
    long denominator = stepSize % p2;
    long inverseDenominatorModP2 = PrimeHelper.extendedEuclideanAlgorithm(denominator, p2).getX();
    if (inverseDenominatorModP2 < 0) {
      inverseDenominatorModP2 += p2;
    }
    // (numerator / denominator) % p2 = (numerator * inverseDenominatorModP2) % p2
    long multiplyer =  (numerator * inverseDenominatorModP2) % p2;
    long result = p1 + multiplyer * stepSize;
    return result;
  }

  public static void main(String[] args) {
    Problem134 problem = new Problem134();
    problem.run(5, 1000000);
  }
}
