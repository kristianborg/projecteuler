package nl.krisborg.projecteuler.problems.problem84;

/**
 * User: no88in
 * Date: 29-4-15
 */
public abstract class BoardHelper {

    public static int moveOne(int currentPosition){
        return move(currentPosition, 1);
    }

    public static int move(int currentPosition, int stepSize) {
        int newPostion = currentPosition + stepSize;
        newPostion %= Constants.BOARD_SIZE;
        while (newPostion < 0){
            newPostion += Constants.BOARD_SIZE;
        }
        return newPostion;
    }
}
