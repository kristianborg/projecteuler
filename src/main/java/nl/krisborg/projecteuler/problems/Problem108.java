package nl.krisborg.projecteuler.problems;

public class Problem108 {

    private void run(int targetDistinctSolutions) {
        for(int n = 4;;n++) {
            int numFactors = getNumFactors(n);
            if (numFactors > targetDistinctSolutions) {
                System.out.println("Done. Result: " + n);
                return;
            }
        }
    }

    private int  getNumFactors(long n) {
        int numSolutions = 0;
        for (long x = n + 1; x <= 2 * n; x++) {

            /*
             * We have 1/n.
             * We rewrite this as ?/x by multiplying numerator and denominator by x/n:
             * 1. 1/n = (x/n) / (n * (x/n)) = (x/n) / x
             *
             * We assume soltion 1 is 1/x.
             * We try to find the other solution by subtracting 1/x:
             * 2. (x/n) / x - 1/x = (x/n) / x - (n/n) / x = ((x-n) / n) / x.
             *
             * Now we rewrite this by myltiplying  numerator and denominator by n:
             * 3. (((x-n) / n) / x) * n = (x-n) / (x*n)
             *
             * This solution is only acceptable if it can be rewritten as 1/y.
             * That can only happen if (x*n) divides (x-n). So we check:
             * 4. (x*n) % (x-n) == 0
             *
             * If this is the case, we have found the second solution
             * 5. y = (x-n) / (x*n)
             */

            // we start by the check from formula (4):
            if (((x * n) % (x - n)) == 0) {
                // now we can get y with formalue (5)
                // long y =  (x*n) / (x-n);
                // System.out.println(String.format("1/%d = 1/%d + 1/%d", n, x, y));
                numSolutions++;
            }
        }
        //System.out.println(String.format("Total number of solutions for %d: %d", n, numSolutions));
        //System.out.println();
        return numSolutions;
    }

    public static void main(String[] args) {
        long before = System.currentTimeMillis();
        new Problem108().run(1000);
        long time = System.currentTimeMillis() - before;
        System.out.println("Took " + time + "ms");
    }
}
