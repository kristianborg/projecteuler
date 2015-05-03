package nl.krisborg.projecteuler.hands;

import junit.framework.TestCase;
import nl.krisborg.projecteuler.HandHelper;
import nl.krisborg.projecteuler.gameobjects.Card;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class HandsTest extends TestCase {


    private HighestCard highestCard =       (HighestCard)   HandHelper.getHighestHand(createCards("2C", "3C", "4C", "7H", "AH"));
    private Pair pair =                     (Pair)          HandHelper.getHighestHand(createCards("2C", "5C", "2D", "7D", "AH"));
    private TwoPair twoPair =               (TwoPair)       HandHelper.getHighestHand(createCards("5C", "7H", "4H", "7C", "4D"));
    private ThreeOfAKind threeOfAKind =     (ThreeOfAKind)  HandHelper.getHighestHand(createCards("AD", "3D", "3H", "KC", "3C"));
    private Straight straight =             (Straight)      HandHelper.getHighestHand(createCards("AD", "3C", "2D", "5C", "4D"));
    private Flush flush =                   (Flush)         HandHelper.getHighestHand(createCards("2C", "4C", "AC", "8C", "7C"));
    private FullHouse fullHouse =           (FullHouse)     HandHelper.getHighestHand(createCards("3C", "7C", "7H", "3D", "7S"));
    private FourOfAKind fourOfAKind =       (FourOfAKind)   HandHelper.getHighestHand(createCards("JC", "JD", "JS", "3H", "JH"));
    private StraightFlush straightFlush =   (StraightFlush) HandHelper.getHighestHand(createCards("2C", "4C", "5C", "3C", "6C"));

    private List<? extends Hand> orderedHands = Arrays.asList(highestCard, pair, twoPair, threeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush);

    public void testRanking(){
        for (int i = 0; i < orderedHands.size(); i++){
            Hand lowestHand = orderedHands.get(i);
            for (int j = i + 1; j < orderedHands.size(); j++){
                Hand highestHand = orderedHands.get(j);
                assertTrue(lowestHand.compareTo(highestHand) < 0);
                assertTrue(highestHand.compareTo(lowestHand) > 0);
            }
        }
    }

    public void testSameHandEquals(){
        for (Hand hand : orderedHands) {
            assertEquals(0, hand.compareTo(hand));
        }
    }

    private List<Card> createCards(String... cards) {
        List<Card> result = new ArrayList<Card>();
        for (String card : cards) {
            result.add(new Card(card));
        }
        return result;
    }
}