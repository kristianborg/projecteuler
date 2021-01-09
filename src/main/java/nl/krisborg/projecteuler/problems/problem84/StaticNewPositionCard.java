package nl.krisborg.projecteuler.problems.problem84;

/**
 * User: no88in
 * Date: 29-4-15
 */
public class StaticNewPositionCard extends Card {

    private int newPosition;

    public StaticNewPositionCard(int newPosition){
        this.newPosition = newPosition;
    }

    public int getNewPosition(int currentPosition){
        return newPosition;
    }
}
