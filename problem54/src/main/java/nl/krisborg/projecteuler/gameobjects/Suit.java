package nl.krisborg.projecteuler.gameobjects;

import com.sun.nio.sctp.IllegalReceiveException;

/**
 * User: no88in
 * Date: 30-4-15
 */
public enum Suit {
    HEARTS("H"),
    DIAMONDS("D"),
    CLUBS("C"),
    SPADES("S");

    String suitString;

    private Suit(String suitString){
        this.suitString = suitString;
    }

    public String getSuitString() {
        return suitString;
    }

    public static Suit toSuit(String suitString) {
        for(Suit s : values()){
            if(s.getSuitString().equals(suitString)){
                return s;
            }
        }
        throw new IllegalArgumentException("Illegal Suit: " + suitString);
    }
}
