package nl.krisborg.projecteuler.problems.problem84;

import java.util.ArrayList;
import java.util.List;

/**
 * User: no88in
 * Date: 29-4-15
 */
public class CardStack {
    List<Card> cards = new ArrayList<Card>();


    public void addCard(Card c){
        cards.add(c);
    }

    public Card pickCard(){
        return cards.get(Constants.RANDOM.nextInt(cards.size()));
    }
}
