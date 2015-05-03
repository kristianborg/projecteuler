package nl.krisborg.projecteuler.hands;

import nl.krisborg.projecteuler.gameobjects.Card;
import nl.krisborg.projecteuler.HandHelper;

import java.util.Collections;
import java.util.List;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class Pair extends Hand<Pair> {

    private List<Card> pair;
    private List<Card> otherCards;

    public Pair(List<Card> pair, List<Card> otherCards) {
        if (!HandHelper.cardsHaveRequalRank(pair) || pair.size() != 2){
            throw new IllegalArgumentException("not a pair");
        }
        this.pair = HandHelper.cloneList(pair);
        this.otherCards = HandHelper.cloneList(otherCards);
        Collections.sort(this.otherCards);
    }

    @Override
    public int compareHandValue(Pair otherPair) {
        return HandHelper.compareFirstListAndThenSecondList(pair, otherPair.pair, otherCards, otherPair.otherCards);
    }

    @Override
    public int getRank() {
        return 1;
    }

    @Override
    public String toString() {
        return "Pair of " + pair.get(0).getRank();
    }
}
