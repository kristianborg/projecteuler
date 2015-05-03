package nl.krisborg.projecteuler.hands;

import nl.krisborg.projecteuler.gameobjects.Card;

import java.util.Collections;
import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public class StraightFlush extends Hand<StraightFlush> {

    private List<Card> cards;

    public StraightFlush(List<Card> cards) {
        this.cards = cards;
        Collections.sort(this.cards);
    }

    @Override
    public int compareHandValue(StraightFlush otherStraightFlush) {
        return cards.get(0).compareTo(otherStraightFlush.cards.get(0));
    }

    @Override
    public int getRank() {
        return 8;
    }

    @Override
    public String toString() {
        return "Straight Flush. " + cards.get(4).getRank() + " high";
    }
}
