package nl.krisborg.projecteuler.hands;

import nl.krisborg.projecteuler.gameobjects.Card;
import nl.krisborg.projecteuler.HandHelper;

import java.util.Collections;
import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public class Flush extends Hand<Flush> {

    private List<Card> cards;

    public Flush(List<Card> cards) {
        if (cards.size() != 5 || !HandHelper.isFlush(cards)){
            throw new IllegalArgumentException("Not A Flush");
        }
        this.cards = cards;
        Collections.sort(this.cards);
    }

    @Override
    public int compareHandValue(Flush otherFlush) {
        return HandHelper.compareCardLists(cards, otherFlush.cards);
    }

    @Override
    public int getRank() {
        return 5;
    }

    @Override
    public String toString() {
        return "Flush of " + cards.get(0).getSuit() + ". " + cards.get(4).getRank() +  " high";
    }
}
