package nl.krisborg.projecteuler;

import java.util.Comparator;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class PositionOccurence implements Comparable<PositionOccurence> {

    int boardPosition;
    int totalRounds;
    int roundsOnCurrentPosition;

    public PositionOccurence(int boardPositions, int totalRounds, int roundsOnCurrentPosition) {
        this.boardPosition = boardPositions;
        this.totalRounds = totalRounds;
        this.roundsOnCurrentPosition = roundsOnCurrentPosition;
    }

    public String getPercentage(){
        double percentage = roundsOnCurrentPosition * 100.0 / totalRounds;
        return String.format( "%.2f", percentage );
    }

    public String getBoardPosition(){
        return String.format( "%02d", boardPosition);
    }

    public int compareTo(PositionOccurence o) {
        return roundsOnCurrentPosition - o.roundsOnCurrentPosition;
    }
}
