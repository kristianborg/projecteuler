import java.lang.String;

class Problem18 {

    int[][] challenge = {
            {75},
            {95, 64},
            {17, 47, 82},
            {18, 35, 87, 10},
            {20,  4, 82, 47, 65},
            {19,  1, 23, 75,  3, 34},
            {88,  2, 77, 73,  7, 63, 67},
            {99, 65,  4, 28,  6, 16, 70, 92},
            {41, 41, 26, 56, 83, 40, 80, 70, 33},
            {41, 48, 72, 33, 47, 32, 37, 16, 94, 29},
            {53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14},
            {70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57},
            {91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48},
            {63, 66,  4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31},
            {04, 62, 98, 27, 23,  9, 70, 98, 73, 93, 38, 53, 60,  4, 23}
    };

    public void run(int maxDepth){
        int[] result = new int[challenge.length];
        for (int row = 0; row < challenge.length; row++){
            if (row == 0){
                result[row] = 0;
            } else {
                result[row] = getBestSubSolution(row, result[row - 1], result[row - 1] + 1, maxDepth);
            }
        }

        System.out.println("result: ");
        int totalScore = 0;
        for (int i = 0; i < result.length; i++){
            int pointer = result[i];
            int score = challenge[i][pointer];
            System.out.println(i + ": " + pointer + ":" + score);
            totalScore += score;
        }
        System.out.println();
        System.out.println("Total score: " + totalScore);
    }

    public int getBestSubSolution(int row, int option1, int option2, int maxDepth){
        int optionOneScore = challenge[row][option1];
        int optionTwoScore = challenge[row][option2];
        if (maxDepth > 1 && row < challenge.length - 1){
            int option1Solution = getBestSubSolution(row + 1, option1, option1 + 1, maxDepth - 1);
            int option2Solution = getBestSubSolution(row + 1, option2, option2 + 1, maxDepth - 1);
            optionOneScore += challenge[row + 1][option1Solution];
            optionTwoScore += challenge[row + 1][option2Solution];
        }
        return optionOneScore > optionTwoScore ? option1 : option2;
    }

    public static void main(String[] argv){
        new Problem18().run(16);
    }
}