package nl.krisborg.projecteuler.problems.problem54;

import nl.krisborg.projecteuler.problems.problem54.gameobjects.Card;
import nl.krisborg.projecteuler.problems.problem54.gameobjects.Rank;
import nl.krisborg.projecteuler.problems.problem54.gameobjects.Suit;
import nl.krisborg.projecteuler.problems.problem54.hands.Flush;
import nl.krisborg.projecteuler.problems.problem54.hands.FourOfAKind;
import nl.krisborg.projecteuler.problems.problem54.hands.FullHouse;
import nl.krisborg.projecteuler.problems.problem54.hands.Hand;
import nl.krisborg.projecteuler.problems.problem54.hands.HighestCard;
import nl.krisborg.projecteuler.problems.problem54.hands.Pair;
import nl.krisborg.projecteuler.problems.problem54.hands.Straight;
import nl.krisborg.projecteuler.problems.problem54.hands.StraightFlush;
import nl.krisborg.projecteuler.problems.problem54.hands.ThreeOfAKind;
import nl.krisborg.projecteuler.problems.problem54.hands.TwoPair;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public abstract class HandHelper {

    public static Hand getHighestHand(List<Card> cards){
        boolean isFlush = isFlush(cards);
        boolean isStraight = isStraight(cards);
        List<Card> carre = extractRankOccurence(cards, 4);
        List<Card> tripple = extractRankOccurence(cards, 3);
        List<Card> pair1 = extractRankOccurence(cards, 2);
        List<Card> pair2 = null;
        if (pair1 != null){
            List<Card> cardsCopy = cloneList(cards);
            cardsCopy.removeAll(pair1);
            pair2 = extractRankOccurence(cardsCopy, 2);;
        }

        if (isStraight && isFlush){
            return new StraightFlush(cards);
        }
        if (carre != null){
            List<Card> leftOverCards = cloneList(cards);
            leftOverCards.removeAll(carre);
            return new FourOfAKind(carre, leftOverCards.get(0));
        }

        if (tripple != null && pair1 != null){
            return new FullHouse(tripple, pair1);
        }

        if (isFlush){
            return new Flush(cards);
        }

        if (isStraight){
            return new Straight(cards);
        }

        if (tripple != null){
            List<Card> leftOverCards = cloneList(cards);
            leftOverCards.removeAll(tripple);
            return new ThreeOfAKind(tripple, leftOverCards);
        }

        if (pair1 != null && pair2 != null){
            List<Card> leftOverCards = cloneList(cards);
            leftOverCards.removeAll(pair1);
            leftOverCards.removeAll(pair2);
            return new TwoPair(pair1, pair2, leftOverCards.get(0));
        }

        if (pair1 != null){
            List<Card> leftOverCards = cloneList(cards);
            leftOverCards.removeAll(pair1);
            return new Pair(pair1, leftOverCards);
        }

        return new HighestCard(cards);

    }

    public static boolean isFlush(List<Card> cards){
        Suit s = cards.get(0).getSuit();
        for (Card card : cards) {
            if (card.getSuit() != s){
                return false;
            }
        }
        return true;
    }

    public static boolean isStraight(List<Card> cards){
        Collections.sort(cards);
        if (cards.get(4).getRank() == Rank.ACE &&
                cards.get(0).getRank() == Rank.TWO &&
                cards.get(1).getRank() == Rank.THREE &&
                cards.get(2).getRank() == Rank.FOUR &&
                cards.get(3).getRank() == Rank.FIVE){
            return true;
        }

        for(int i = 0; i < cards.size() - 1; i++){
            Card c1 = cards.get(i);
            Card c2 = cards.get(i + 1);
            if (c2.getRank().ordinal() - c1.getRank().ordinal() != 1){
                return false;
            }
        }
        return true;
    }

    public static int compareFirstListAndThenSecondList(List<Card> firstList1, List<Card> firstList2, List<Card> secondList1, List<Card> secondList2){
        int firstListDiff = compareCardLists(firstList1, firstList2);
        if (firstListDiff != 0){
            return firstListDiff;
        } else {
            return compareCardLists(secondList1, secondList2);
        }
    }

    public static int compareCardLists(List<Card> list1, List<Card> list2){
        Collections.sort(list1);
        Collections.sort(list2);
        if (list1.size() != list2.size()){
            throw new IllegalArgumentException("Number of cards differ");
        }

        for(int i = list1.size() - 1; i >= 0; i--){
            int diffCurrentCard = list1.get(i).compareTo(list2.get(i));
            if (diffCurrentCard != 0){
                return diffCurrentCard;
            }
        }
        return 0;
    }

    public static boolean cardsHaveRequalRank(List<Card> cards){
        Rank rank = cards.get(0).getRank();
        for (Card card : cards) {
            if (card.getRank() != rank){
                return false;
            }
        }
        return true;
    }

    public static List<Card> cloneList(List<Card> cards) {
        List<Card> result = new ArrayList<Card>();
        for (Card card : cards) {
            result.add(card);
        }
        return result;
    }

    protected static List<Card> extractRankOccurence(List<Card> cards, int targetOccurence) {
        int[] rankOccurence = new int[Rank.values().length];
        for (Card card : cards) {
            rankOccurence[card.getRank().ordinal()]++;
        }

        Rank resultRank = null;
        for(Rank rank : Rank.values()){
            if (rankOccurence[rank.ordinal()] == targetOccurence){
                resultRank = rank;
                break;
            }
        }

        if (resultRank == null){
            return null;
        }

        List<Card> result = new ArrayList<Card>();
        for (Card card : cards) {
            if (card.getRank() == resultRank){
                result.add(card);
            }
        }
        return result;
    }
}
