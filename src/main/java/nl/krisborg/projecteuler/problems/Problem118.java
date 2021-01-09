package nl.krisborg.projecteuler.problems;

import java.util.*;

/**
 * User: no88in
 * Date: 14-7-15
 */
public class Problem118 {

    public static void main(String[] argv){
        long before = System.currentTimeMillis();
        List<String> primeCandidates = getPrimesCandidates();
        int result = solve("", 0, 0, primeCandidates);
        long after = System.currentTimeMillis();
        System.out.println("Found " + result + " solutions in " + (after - before) + "ms");
    }

    private static int solve(String subResult, int subResultLength, int nexPointer, List<String> primeCandidates){
        if (subResultLength == 9){
            return 1;
        }

        int numResults = 0;
        for (int i = nexPointer; i < primeCandidates.size(); i++){
            String primeCandidate = primeCandidates.get(i);
            if (primeCandidate.length() + subResultLength > 9){
                break;
            }

            if (!containsOverlappingDigitis(subResult, primeCandidate)){
                String newSubresult = subResult + "," + primeCandidate;
                numResults += solve(newSubresult, subResultLength + primeCandidate.length(), i, primeCandidates);
            }
        }
        return numResults;
    }

    private static boolean containsOverlappingDigitis(String haystack, String needles) {
        for (int i = 0; i < haystack.length(); i++){
            String character = haystack.substring(i, i + 1);
            if (needles.contains(character)){
                return true;
            }
        }
        return false;
    }

    private static List<String> getPrimesCandidates() {

        boolean[] primes = new boolean[987654321];
        for (int i = 2; i < primes.length; i++){
            primes[i]= true;
        }

        for (int i = 2; i <= Math.sqrt(primes.length); i++){
            if (primes[i]) {
                for (int j = i * 2; j < primes.length; j += i) {
                    primes[j] = false;
                }
            }
        }

        List<String> result = new ArrayList<>();
        for (int i = 2; i < primes.length; i++){
            if (primes[i]){
                if (isInterestingPrime(i)){
                    result.add(Integer.toString(i));
                }
            }
        }

        return result;
    }

    private static boolean isInterestingPrime(int number) {
        String numberString = Integer.toString(number);
        if (numberString.contains("0")){
            return false;
        }
        for (int i = 0; i < numberString.length() - 1; i++){
            String charAtPosition = numberString.substring(i, i + 1);
            int nextCharPosition = numberString.indexOf(charAtPosition, i + 1);
            if (nextCharPosition != -1){
                return false;
            }
        }

        return true;
    }
}
