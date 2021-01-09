package nl.krisborg.projecteuler.problems.problem54.gameobjects;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class Card implements Comparable<Card> {
    private Rank rank;
    private Suit suit;

    public Card(String s){
        if (s.length() != 2){
            throw new IllegalArgumentException("Invalid Card String: " + s);
        }
        String rankString = s.substring(0, 1);
        String suitString = s.substring(1, 2);

        this.rank = Rank.toRank(rankString);
        this.suit = Suit.toSuit(suitString);
    }

    public Card(Rank rank, Suit suit) {
        if (rank == null || suit == null){
            throw new IllegalArgumentException("Rank or suite cannot be null");
        }
        this.rank = rank;
        this.suit = suit;
    }

    public Rank getRank() {
        return rank;
    }

    public Suit getSuit() {
        return suit;
    }

    public int compareTo(Card o) {
        return rank.ordinal() - o.rank.ordinal();
    }
}
