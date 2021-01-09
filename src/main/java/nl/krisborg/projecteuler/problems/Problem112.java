package nl.krisborg.projecteuler.problems;

public class Problem112 {


    public static void main(String[] argv){
        int bouncy = 0;
        int nonbouncy = 0;
        int totalNumbers = 0;
        int i = 1;
        double targetPercentage = 99;
        while (true){
            totalNumbers++;
            if (isBouncy(i)){
                bouncy++;
            } else {
                nonbouncy++;
            }
            double percentage = (100d * bouncy) / totalNumbers;
            if (percentage >= targetPercentage){
                break;
            }
            i++;
        }
        System.out.println("total numbers: " + totalNumbers);
        System.out.println("Bouncy numbers: " + bouncy);
        System.out.println("Non bouncy numbers: " + nonbouncy);
        System.out.println("Percentage bouncy numbers: " + ((100d * bouncy) / totalNumbers));
    }

    private static boolean isBouncy(int numberInt) {
        if (numberInt < 100){
            return false;
        }

        String numberString = Integer.toString(numberInt);
        char[] numberArray = numberString.toCharArray();
        int direction = 0;
        for(int i = 1; i < numberArray.length; i++){
            if (direction > 0){
                if (numberArray[i - 1] > numberArray[i]){
                    return true;
                }
            } else if (direction < 0){
                if (numberArray[i - 1] < numberArray[i]){
                    return true;
                }
            } else {
                direction = numberArray[i] - numberArray[i - 1];
            }
        }
        return false;
    }


}