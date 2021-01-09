package nl.krisborg.projecteuler.problems.problem54.hands;

import nl.krisborg.projecteuler.problems.problem54.gameobjects.Card;
import nl.krisborg.projecteuler.problems.problem54.HandHelper;

import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public class FourOfAKind extends Hand<FourOfAKind> {

    private List<Card> fourOfAKind;
    private Card otherCard;

    public FourOfAKind(List<Card> fourOfAKind, Card otherCard) {
        if (fourOfAKind.size() != 4 || !HandHelper.cardsHaveRequalRank(fourOfAKind)){
            throw new IllegalArgumentException("Not A Carre");
        }
        this.fourOfAKind = fourOfAKind;
        this.otherCard = otherCard;
    }

    @Override
    public int compareHandValue(FourOfAKind otherFourOfAKind) {
        return fourOfAKind.get(0).compareTo(otherFourOfAKind.fourOfAKind.get(0));
    }

    @Override
    public int getRank() {
        return 7;
    }

    @Override
    public String toString() {
        return "Four of a kind " + fourOfAKind.get(0).getRank();
    }
}
