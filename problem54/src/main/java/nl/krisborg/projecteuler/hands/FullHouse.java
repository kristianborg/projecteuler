package nl.krisborg.projecteuler.hands;

import nl.krisborg.projecteuler.gameobjects.Card;
import nl.krisborg.projecteuler.HandHelper;

import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public class FullHouse extends Hand<FullHouse> {

    private List<Card> tripple;
    private List<Card> pair;

    public FullHouse(List<Card> tripple, List<Card> pair) {
        if (tripple.size() != 3 || pair.size() != 2 || !HandHelper.cardsHaveRequalRank(tripple) || !HandHelper.cardsHaveRequalRank(pair)){
            throw new IllegalArgumentException("Not a Full House");
        }
        this.tripple = tripple;
        this.pair = pair;
    }

    @Override
    public int compareHandValue(FullHouse otherFullHouse) {
        return HandHelper.compareFirstListAndThenSecondList(tripple, otherFullHouse.tripple, pair, otherFullHouse.pair);
    }

    @Override
    public int getRank() {
        return 6;
    }

    @Override
    public String toString() {
        return "FullHouse " + tripple.get(0).getRank() + " over " + pair.get(0).getRank();
    }
}
