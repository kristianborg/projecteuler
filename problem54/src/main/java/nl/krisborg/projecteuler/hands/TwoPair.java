package nl.krisborg.projecteuler.hands;

import nl.krisborg.projecteuler.gameobjects.Card;
import nl.krisborg.projecteuler.HandHelper;

import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public class TwoPair extends Hand<TwoPair> {

    private List<Card> highestPair;
    private List<Card> lowestPair;
    private Card otherCard;

    public TwoPair(List<Card> pair1, List<Card> pair2, Card otherCard) {
        if (pair1.size() != 2 || pair2.size() != 2 || !HandHelper.cardsHaveRequalRank(pair1) || !HandHelper.cardsHaveRequalRank(pair2)){
            throw new IllegalArgumentException("Not a Two Pair Hand");
        }

        if (pair1.get(0).compareTo(pair2.get(0)) > 0){
            highestPair = pair1;
            lowestPair = pair2;
        } else {
            highestPair = pair2;
            lowestPair = pair1;
        }
        this.otherCard = otherCard;
    }

    @Override
    public int compareHandValue(TwoPair otherTwoPair) {
        int highestPairDiff = highestPair.get(0).compareTo(otherTwoPair.highestPair.get(0));
        if (highestPairDiff != 0){
            return highestPairDiff;
        }

        int lowestPairDiff = lowestPair.get(0).compareTo(otherTwoPair.lowestPair.get(0));
        if (lowestPairDiff != 0){
            return lowestPairDiff;
        }

        return otherCard.compareTo(otherTwoPair.otherCard);
    }

    @Override
    public int getRank() {
        return 2;
    }

    @Override
    public String toString() {
        return "Two Pair " + highestPair.get(0).getRank() + " over " + lowestPair.get(0).getRank();
    }
}
