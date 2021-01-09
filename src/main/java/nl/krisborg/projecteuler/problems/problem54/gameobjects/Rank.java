package nl.krisborg.projecteuler.problems.problem54.gameobjects;

/**
 * User: no88in
 * Date: 30-4-15
 */
public enum Rank {
    TWO("2"),
    THREE("3"),
    FOUR("4"),
    FIVE("5"),
    SIX("6"),
    SEVEN("7"),
    EIGHT("8"),
    NINE("9"),
    TEN("T"),
    JACK("J"),
    QUEEN("Q"),
    KING("K"),
    ACE("A");

    String rankString;

    private Rank(String rankString){
        this.rankString = rankString;
    }

    public String getRankString() {
        return rankString;
    }

    public static Rank toRank(String rankString) {
        for(Rank r : values()){
            if (r.getRankString().equals(rankString)){
                return r;
            }
        }
        throw new IllegalArgumentException("Illegal rank: " + rankString);
    }
}
