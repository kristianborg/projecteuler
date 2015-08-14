import java.util.ArrayList;
import java.util.List;

public class Problem113 {

    public static void main(String[] argv){
        int maxDecimals = 100;
        long result = getIncreasingNumbers(maxDecimals) + getDecreasingNumbers(maxDecimals) - getOverlappingNumbers(maxDecimals);
        System.out.println("num bouncy numbers up to " + maxDecimals + " digits: " + result);
    }

    public static long getOverlappingNumbers(int maxDecimals){
        return maxDecimals * 9;
    }

    private static long getIncreasingNumbers(int maxNumDecimals){
        List<long[]> increasing = new ArrayList<long[]>();
        increasing.add(new long[]{1, 1, 1, 1, 1, 1, 1, 1, 1});
        expand(increasing, maxNumDecimals);
        return getSum(increasing);
    }

    private static long getDecreasingNumbers(int maxNumDecimals){
        List<long[]> decreasing = new ArrayList<long[]>();
        decreasing.add(new long[]{1, 1, 1, 1, 1, 1, 1, 1, 1, 1});
        expand(decreasing, maxNumDecimals);
        return getSum(decreasing) - maxNumDecimals; // minus one because 0, 00, 000, etc is included as solution
    }

    private static void expand(List<long[]> numbers, int maxNumDecimals){
        for (int numDecimals = 2; numDecimals <= maxNumDecimals; numDecimals++){
            long[] previous = numbers.get(numbers.size() - 1);
            int arraySize = previous.length;
            long[] current = new long[arraySize];

            for(int i = 0; i < arraySize; i++){
                long sum = 0;
                for(int j = i; j < arraySize; j++){
                    sum += previous[j];
                }
                current[i] = sum;
            }
            numbers.add(current);
        }
    }

    private static long getSum(List<long[]> numbersList){
        long result = 0;
        for (long[] numbers : numbersList) {
            for (long number : numbers) {
                result += number;
            }
        }
        return result;
    }
}
