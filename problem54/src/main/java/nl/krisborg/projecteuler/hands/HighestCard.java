package nl.krisborg.projecteuler.hands;

import nl.krisborg.projecteuler.gameobjects.Card;
import nl.krisborg.projecteuler.HandHelper;

import java.util.Collections;
import java.util.List;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class HighestCard extends Hand<HighestCard> {

    private List<Card> cards;

    public HighestCard(List<Card> cards) {
        this.cards = HandHelper.cloneList(cards);
        Collections.sort(cards);
    }

    @Override
    public int compareHandValue(HighestCard otherHighestCard) {
        return HandHelper.compareCardLists(cards, otherHighestCard.cards);
    }

    @Override
    public int getRank() {
        return 0;
    }

    @Override
    public String toString() {
        return "Highest Card: " + cards.get(4).getRank();
    }
}
