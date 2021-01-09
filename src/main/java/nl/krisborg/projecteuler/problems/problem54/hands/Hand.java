package nl.krisborg.projecteuler.problems.problem54.hands;

/**
 * User: no88in
 * Date: 30-4-15
 */
public abstract class Hand<T> implements Comparable<Hand> {

    public int compareTo(Hand other) {
        if (getRank() == other.getRank()){
            return compareHandValue((T)other);
        } else {
            return getRank() - other.getRank();
        }
    }

    protected abstract int compareHandValue(T other);

    protected abstract int getRank();

    public abstract String toString();
}
