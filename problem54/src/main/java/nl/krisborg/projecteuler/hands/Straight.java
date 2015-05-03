package nl.krisborg.projecteuler.hands;

import nl.krisborg.projecteuler.gameobjects.Card;
import nl.krisborg.projecteuler.HandHelper;

import java.util.Collections;
import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public class Straight extends Hand<Straight> {

    private List<Card> cards;

    public Straight(List<Card> cards) {
        if (cards.size() != 5 || !HandHelper.isStraight(cards)){
            throw new IllegalArgumentException("Not A Straight");
        }
        this.cards = HandHelper.cloneList(cards);
        Collections.sort(this.cards);
    }

    @Override
    public int compareHandValue(Straight otherStraight) {
        return cards.get(0).compareTo(otherStraight.cards.get(0));
    }

    @Override
    public int getRank() {
        return 4;
    }

    @Override
    public String toString() {
        return "Straight. " + cards.get(4).getRank() + " high";
    }
}
