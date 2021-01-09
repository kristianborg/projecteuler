package nl.krisborg.projecteuler.problems.problem54.hands;

import nl.krisborg.projecteuler.problems.problem54.gameobjects.Card;
import nl.krisborg.projecteuler.problems.problem54.HandHelper;

import java.util.Collections;
import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public class ThreeOfAKind extends Hand<ThreeOfAKind> {

    private List<Card> threeOfAKind;
    private List<Card> otherCards;

    public ThreeOfAKind(List<Card> threeOfAKind, List<Card> otherCards) {
        if (threeOfAKind.size() != 3 || !HandHelper.cardsHaveRequalRank(threeOfAKind)){
            throw new IllegalArgumentException("Not A Tripple Hand");
        }
        this.threeOfAKind = threeOfAKind;
        this.otherCards = otherCards;
        Collections.sort(otherCards);
    }

    @Override
    public int compareHandValue(ThreeOfAKind otherThreeOfAKind) {
        return HandHelper.compareFirstListAndThenSecondList(threeOfAKind, otherThreeOfAKind.threeOfAKind, otherCards, otherThreeOfAKind.otherCards);
    }

    @Override
    public int getRank() {
        return 3;
    }

    @Override
    public String toString() {
        return "Tripple of " + threeOfAKind.get(0).getRank();
    }
}
