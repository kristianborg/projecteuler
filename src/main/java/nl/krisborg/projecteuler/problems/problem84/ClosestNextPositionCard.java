package nl.krisborg.projecteuler.problems.problem84;

import java.util.List;

/**
 * User: no88in
 * Date: 29-4-15
 */
public class ClosestNextPositionCard extends Card {

    private List<Integer> nextPositions;

    public ClosestNextPositionCard(List<Integer> nextPositions) {
        this.nextPositions = nextPositions;
    }

    @Override
    public int getNewPosition(int currentPosition) {
        Integer nextPosition = BoardHelper.moveOne(currentPosition);;
        while (!nextPositions.contains(nextPosition)){
            nextPosition = BoardHelper.moveOne(nextPosition);
        }
        return nextPosition;
    }
}
