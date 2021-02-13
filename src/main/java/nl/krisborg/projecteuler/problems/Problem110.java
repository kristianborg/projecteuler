package nl.krisborg.projecteuler.problems;

import nl.krisborg.projecteuler.lib.PrimeHelper;

import java.util.*;

public class Problem110 {

    private List<Integer> getFrequencies(List<Integer> number) {
        List<Integer> frequencies = new ArrayList<>();
        int previousNumber = 0;
        int previousNumberOccurence = 0;
        for (int i = 0; i < number.size(); i++) {
            int factor = number.get(i);
            if (factor == previousNumber || previousNumber == 0) {
                previousNumberOccurence++;
            } else {
                frequencies.add(previousNumberOccurence);
                previousNumberOccurence = 1;
            }
            previousNumber = factor;
        }
        frequencies.add(previousNumberOccurence);
        return frequencies;
    }

    /*
     * In problem 108 we found that we are looking for all values of x for which holds:
     * 1. (x*n) % (x-n) == 0
     *
     * Since our calculations is mod (x-n) we can add/remove (x-n) as many times as we want to the left-hand side. For example:
     * 2. (x*n) - (n * (x-n)) = (x*n) - (n*x) + n^2 = n^2.
     *
     * Thefor it follows we are looking for solutions for:
     * 3. n^2 % (x-n) = 0
     *
     * In otherwords, we are looking for all the ways in which n^2 can be split up by multiplying two numbers
     *
     * If we rewrite n as it's prime factos we get n = p1^n1 * p2^n2 * p3^n3 *....
     * Since we solve for n^2, we are solving for n^2 = p1^2*n1 * p2^2*n2 * p3^2*n3 *....
     *
     * The solution to our problem is the number of ways in which we can split this product of prime factors in 2 unique sets
     * According to https://stackoverflow.com/questions/736494/how-do-you-calculate-the-total-number-of-all-possible-unique-subsets-from-a-set
     * the solutions for this is (2*n1+1) * (2*n2+1) * (2*n3+1) * ....
     *
     * Note: the result contains every solution twice, since it will return both n = a * b, and n = b * a.
     *
     */
    public int getNumSolutionsForN(long n) {
        List<Integer> primeFactorsNSquared = PrimeHelper.getPrimeFactors(n);
        primeFactorsNSquared.addAll(primeFactorsNSquared);
        primeFactorsNSquared.sort(Comparator.comparingInt(a -> a));
        List<Integer> frequencies = new ArrayList<>();
        // product of uneven numbers = x where the sum of the numbers is smallest

        int previousFactor = 0;
        int previousFactorOccurence = 0;
        for (int i = 0; i < primeFactorsNSquared.size(); i++) {
            int factor = primeFactorsNSquared.get(i);
            if (factor == previousFactor || previousFactor == 0) {
                previousFactorOccurence++;
            } else {
                frequencies.add(previousFactorOccurence);
                previousFactorOccurence = 1;
            }
            previousFactor = factor;
        }
        frequencies.add(previousFactorOccurence);

        int result = 1;
        for (Integer frequency : frequencies) {
            result *= (frequency + 1);
        }

        return (result + 1) / 2;
    }

    private List<List<Integer>> findNewSolutions(List<Integer> solution, long targetNumSolutions, long maxN) {
        // duplicate one of the primes in the list
        List<List<Integer>> result = new ArrayList<>();
        if (getNumSolutionsForN(multiply(solution)) > targetNumSolutions) {
            result.add(solution);
        }

        List<List<Integer>> newSolutionCandidates = new ArrayList<>();
        for (Integer prime : solution) {
            List<Integer> newSolution = new ArrayList<>(solution);
            newSolution.add(prime);
            newSolution.sort(Comparator.comparingInt(a -> a));
            newSolutionCandidates.add(newSolution);
        }
        newSolutionCandidates = removeDuplicates(newSolutionCandidates);
        for (List<Integer> newSolutionCandidate : newSolutionCandidates) {
            long newSolutionCandidateN = multiply(solution);
            long numSolutions = getNumSolutionsForN(newSolutionCandidateN);
            if (newSolutionCandidateN > maxN) {
                // skip this one
                new String();
            } else if (numSolutions > targetNumSolutions) {
                // add this one to result
                result.add(newSolutionCandidate);
            } else {
                // keep looking
                result.addAll(findNewSolutions(newSolutionCandidate, targetNumSolutions, maxN));
            }
        }
        return result;
    }

    public void solve(long target) {
        /*
         * We need to find the first n for which the number of distinct solutions exceeds target.
         * We start by multiplying primes untill we find a number that exceeds the target.
         * This is our starting point we try to improve later
         */
        List<Integer> primes = PrimeHelper.getPrimes(100);
        List<Integer> resultFactors = new ArrayList<>();
        long result = 1;
        for (Integer prime : primes) {
            resultFactors.add(prime);
            result *= prime;
            if (getNumSolutionsForN(result) > target) {
                break;
            }
        }

        /*
         * Our starting point is a number that is the product of consecutive primes: p1 * p2 * p3 * p4 * p5 * ....
         * We try to improve on this result by removing the highest prime and replacing it with additional multiplications of lower primes. For example p1^2 * p2^2 * p3 *....
         * Hopefully we find a number whose product is lower than our starting point, but whose number of solutions still exceeds the target.
         * We keep doing this untill we find now better solution anymore.
         *
         * Note: I have no prove that this method guarantees the best possible solution. But it is good enough to get the correct answer for the problem.
         */
        List<Integer> previousSolution = resultFactors;
        while (previousSolution != null) {
            previousSolution.remove(previousSolution.size() - 1);
            List<List<Integer>> newSolutions = findNewSolutions(previousSolution, target, result);
            newSolutions = removeDuplicates(newSolutions);
            for (List<Integer> newSolutionForCurrent : newSolutions) {
                if (multiply(newSolutionForCurrent) < result) {
                    result = multiply(newSolutionForCurrent);
                }
            }
            previousSolution = null;
            for (List<Integer> newSolution : newSolutions) {
                if (multiply(newSolution) == result) {
                    previousSolution = newSolution;
                }
            }
        }
        System.out.println("Expected: " + "9350130049860600");
        System.out.println("Result:   " + result);
    }

    private List<List<Integer>> removeDuplicates(List<List<Integer>> solutions) {
        Set<String> seenKeys = new HashSet<>();
        List<List<Integer>> result = new ArrayList<>();
        for (List<Integer> solution : solutions) {
            List<Integer> frequencies = getFrequencies(solution);
            frequencies.sort(Comparator.comparingInt(a -> a));
            String key = frequencies.toString();
            if (!seenKeys.contains(key)) {
                seenKeys.add(key);
                result.add(solution);
            }
        }
        return result;
    }

    private long multiply(List<Integer> numbers) {
        long result = 1;
        for (long number : numbers) {
            result *= number;
        }
        return result;
    }

    public static void main(String[] args) {
        new Problem110().solve(4000000);
    }
}
