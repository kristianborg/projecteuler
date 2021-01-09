package nl.krisborg.projecteuler.problems.problem84;

/**
 * User: no88in
 * Date: 29-4-15
 */
public abstract class Card {

    public abstract int getNewPosition(int currentPosition);

    public String getName(){
        return this.getClass().getSimpleName();
    }
}
