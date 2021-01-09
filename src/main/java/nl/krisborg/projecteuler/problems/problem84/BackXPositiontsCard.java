package nl.krisborg.projecteuler.problems.problem84;

/**
 * User: no88in
 * Date: 29-4-15
 */
public class BackXPositiontsCard extends Card {

    private int positionsBack;

    public BackXPositiontsCard(int positionsBack){
        this.positionsBack = positionsBack;
    }

    public int getNewPosition(int currentPosition) {
        return BoardHelper.move(currentPosition, -1 * positionsBack);
    }
}
