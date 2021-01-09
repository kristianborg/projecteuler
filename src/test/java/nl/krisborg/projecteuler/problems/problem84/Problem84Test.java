package nl.krisborg.projecteuler.problems.problem84;

import junit.framework.TestCase;
import org.junit.Test;

import java.util.Random;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class Problem84Test extends TestCase {

    public void testRegularThrow(){
        Problem84 p = createProblem84(0, 1, 2, null);
        p.play();
        assertEquals(3, p.currentPosition);
        assertEquals(0, p.currentDoubleStreakSize);
    }

    public void testDoubleThrow(){
        Problem84 p = createProblem84(0, 2, 2, null);
        p.play();
        assertEquals(4, p.currentPosition);
        assertEquals(1, p.currentDoubleStreakSize);
    }

    public void testResetDoubleStreak(){
        Problem84 p = createProblem84(0, 1, 2, null);
        p.currentDoubleStreakSize = 1;
        p.play();
        assertEquals(3, p.currentPosition);
        assertEquals(0, p.currentDoubleStreakSize);
    }

    public void testDoubleLeadsToJail(){
        Problem84 p = createProblem84(0, 1, 1, null);
        p.currentDoubleStreakSize = 2;
        p.play();
        assertEquals(Constants.JAIL, p.currentPosition);
        assertEquals(0, p.currentDoubleStreakSize);
    }

    public void testGoToJail(){
        Problem84 p = createProblem84(27, 1, 2, null);
        p.play();
        assertEquals(Constants.JAIL, p.currentPosition);
    }

    public void testChanceCard(){
        Problem84 p = createProblem84(5, 1, 1, 27);
        p.play();
        assertEquals(27, p.currentPosition);
    }

    public void testCommunityChestCard(){
        Problem84 p = createProblem84(0, 1, 1, 28);
        p.play();
        assertEquals(28, p.currentPosition);
    }

    public void testGoToJailAfterChanceCard(){
        Problem84 p = createProblem84(5, 1, 1, Constants.GO_TO_JAIL);
        p.play();
        assertEquals(Constants.JAIL, p.currentPosition);
    }



    private Problem84 createProblem84(int currentPosition, final int dice1, final int dice2, Integer specialCardPosition){

        Problem84 p = new Problem84(){
            int call = 0;

            @Override
            protected int throwDice() {
                call++;
                if (call == 1){
                    return dice1;
                } else if (call == 2){
                    return dice2;
                } else {
                    throw new RuntimeException("Too many nextInt() calls");
                }
            }
        };

        p.currentPosition = currentPosition;

        if (specialCardPosition != null) {
            CardStack cs = new CardStack();
            cs.addCard(new StaticNewPositionCard(specialCardPosition));
            p.communityChestCards = cs;
            p.chanceCards = cs;
        }

        return p;
    }

}