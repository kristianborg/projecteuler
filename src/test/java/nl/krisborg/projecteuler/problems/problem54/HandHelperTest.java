package nl.krisborg.projecteuler.problems.problem54;

import junit.framework.TestCase;
import nl.krisborg.projecteuler.problems.problem54.gameobjects.Card;
import nl.krisborg.projecteuler.problems.problem54.gameobjects.Rank;
import nl.krisborg.projecteuler.problems.problem54.hands.Flush;
import nl.krisborg.projecteuler.problems.problem54.hands.FourOfAKind;
import nl.krisborg.projecteuler.problems.problem54.hands.FullHouse;
import nl.krisborg.projecteuler.problems.problem54.hands.HighestCard;
import nl.krisborg.projecteuler.problems.problem54.hands.Pair;
import nl.krisborg.projecteuler.problems.problem54.hands.Straight;
import nl.krisborg.projecteuler.problems.problem54.hands.StraightFlush;
import nl.krisborg.projecteuler.problems.problem54.hands.ThreeOfAKind;
import nl.krisborg.projecteuler.problems.problem54.hands.TwoPair;

import java.util.ArrayList;
import java.util.List;

public class HandHelperTest extends TestCase {


    public void testIsFlush(){
        assertFalse(HandHelper.isFlush(createCards("2D", "3D", "4D", "5D", "6S")));
        assertFalse(HandHelper.isFlush(createCards("AS", "2D", "3D", "4D", "5D")));
        assertFalse(HandHelper.isFlush(createCards("AS", "2D", "5C", "JH", "5D")));
        assertTrue(HandHelper.isFlush(createCards("AS", "JS", "3S", "QS", "TS")));
        assertTrue(HandHelper.isFlush(createCards("2D", "JD", "3D", "7D", "TD")));
    }

    public void testIsTraight(){
        assertFalse(HandHelper.isStraight(createCards("AS", "2D", "5C", "JH", "5D")));
        assertFalse(HandHelper.isStraight(createCards("JC", "QC", "KC", "AC", "2C")));
        assertFalse(HandHelper.isStraight(createCards("4D", "5C", "7C", "8S", "9S")));
        assertTrue(HandHelper.isStraight(createCards("4D", "5C", "6D", "7C", "8S")));
        assertTrue(HandHelper.isStraight(createCards("4D", "6C", "7D", "5C", "8S")));
        assertTrue(HandHelper.isStraight(createCards("AD", "2C", "3D", "4C", "5S")));
        assertTrue(HandHelper.isStraight(createCards("4D", "2C", "3D", "5C", "AS")));
        assertTrue(HandHelper.isStraight(createCards("TD", "JC", "QD", "KC", "AD")));
        assertTrue(HandHelper.isStraight(createCards("QD", "TC", "JD", "KC", "AD")));
    }

    public void testCompareCardLists(){
        assertTrue(HandHelper.compareCardLists(createCards("3D", "7S", "QC"), createCards("QH", "3C", "7S")) == 0);
        assertTrue(HandHelper.compareCardLists(createCards("AD", "2S", "3C"), createCards("KH", "QC", "JS")) > 0);
        assertTrue(HandHelper.compareCardLists(createCards("AD", "KS", "JC"), createCards("AH", "KC", "TS")) > 0);
        assertTrue(HandHelper.compareCardLists(createCards("KD", "4S", "2C"), createCards("KH", "4C", "3S")) < 0);
    }

    public void testCompareFirstListAndThenSecondList(){
        assertTrue(HandHelper.compareFirstListAndThenSecondList(
                createCards("3D", "7S", "QC"),
                createCards("QH", "3C", "7S"),
                createCards("6H", "AH", "JH"),
                createCards("JD", "6C", "AC")) == 0);

        assertTrue(HandHelper.compareFirstListAndThenSecondList(
                createCards("3D", "7S", "QC"),
                createCards("QH", "3C", "7S"),
                createCards("6H", "AH", "JH"),
                createCards("JD", "7C", "AC")) < 0);

        assertTrue(HandHelper.compareFirstListAndThenSecondList(
                createCards("3D", "7S", "QC"),
                createCards("QH", "3C", "7S"),
                createCards("6H", "AH", "JH"),
                createCards("JD", "6C", "2C")) > 0);

        assertTrue(HandHelper.compareFirstListAndThenSecondList(
                createCards("3D", "4S", "5C"),
                createCards("4H", "5C", "6S"),
                createCards("AH", "AC", "AS"),
                createCards("2H", "2C", "2S")) < 0);

        assertTrue(HandHelper.compareFirstListAndThenSecondList(
                createCards("AD", "AS", "AC"),
                createCards("AH", "AH", "KC"),
                createCards("2H", "2C", "2S"),
                createCards("AH", "AC", "AS")) > 0);
    }

    public void testCardsHaveRequalRank(){
        assertTrue(HandHelper.cardsHaveRequalRank(createCards("3C", "3S", "3D", "3H")));
        assertTrue(HandHelper.cardsHaveRequalRank(createCards("AC", "AD")));
        assertFalse(HandHelper.cardsHaveRequalRank(createCards("2C", "3S", "3D", "3H")));
        assertFalse(HandHelper.cardsHaveRequalRank(createCards("3C", "3S", "3D", "AH")));
        assertFalse(HandHelper.cardsHaveRequalRank(createCards("3C", "3S", "JD", "3H")));
        assertFalse(HandHelper.cardsHaveRequalRank(createCards("JC", "QD")));
    }

    public void testExtractRankOccurence(){
        List<Card> inputCards = createCards("QD", "AH", "JD", "TD", "2D", "JH", "AH", "2C", "7C", "7D", "7H", "7S", "AH");
        List<Card> cards2 = HandHelper.extractRankOccurence(inputCards, 2);
        assertEquals(2, cards2.size());
        assertEquals(Rank.TWO, cards2.get(0).getRank());
        assertEquals(Rank.TWO, cards2.get(1).getRank());

        List<Card> cards3 = HandHelper.extractRankOccurence(inputCards, 3);
        assertEquals(3, cards3.size());
        assertEquals(Rank.ACE, cards3.get(0).getRank());
        assertEquals(Rank.ACE, cards3.get(1).getRank());
        assertEquals(Rank.ACE, cards3.get(2).getRank());

        List<Card> cards4 = HandHelper.extractRankOccurence(inputCards, 4);
        assertEquals(4, cards4.size());
        assertEquals(Rank.SEVEN, cards4.get(0).getRank());
        assertEquals(Rank.SEVEN, cards4.get(1).getRank());
        assertEquals(Rank.SEVEN, cards4.get(2).getRank());
        assertEquals(Rank.SEVEN, cards4.get(3).getRank());


        List<Card> inputCardsTwo = createCards("QD", "AH", "JD", "TD", "2D", "7C");
        assertNull(HandHelper.extractRankOccurence(inputCardsTwo, 2));
        assertNull(HandHelper.extractRankOccurence(inputCardsTwo, 3));
        assertNull(HandHelper.extractRankOccurence(inputCardsTwo, 4));
    }

    public void testGetHighestHand(){
        assertTrue(HandHelper.getHighestHand(createCards("2C", "3C", "4C", "7H", "AH")) instanceof HighestCard);
        assertTrue(HandHelper.getHighestHand(createCards("2C", "5C", "2D", "7D", "AH")) instanceof Pair);
        assertTrue(HandHelper.getHighestHand(createCards("5C", "7H", "4H", "7C", "4D")) instanceof TwoPair);
        assertTrue(HandHelper.getHighestHand(createCards("AD", "3D", "3H", "KC", "3C")) instanceof ThreeOfAKind);
        assertTrue(HandHelper.getHighestHand(createCards("AD", "3C", "2D", "5C", "4D")) instanceof Straight);
        assertTrue(HandHelper.getHighestHand(createCards("2C", "4C", "AC", "8C", "7C")) instanceof Flush);
        assertTrue(HandHelper.getHighestHand(createCards("3C", "7C", "7H", "3D", "7S")) instanceof FullHouse);
        assertTrue(HandHelper.getHighestHand(createCards("JC", "JD", "JS", "3H", "JH")) instanceof FourOfAKind);
        assertTrue(HandHelper.getHighestHand(createCards("2C", "4C", "5C", "3C", "6C")) instanceof StraightFlush);
    }

    private List<Card> createCards(String... cards) {
        List<Card> result = new ArrayList<Card>();
        for (String card : cards) {
            result.add(new Card(card));
        }
        return result;
    }
}