package nl.krisborg.projecteuler.problems.problem84;

import junit.framework.TestCase;
import org.junit.Test;

import java.util.Arrays;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class ClosestNextPositionCardTest extends TestCase {


    @Test
    public void testIt(){
        ClosestNextPositionCard  card = new ClosestNextPositionCard(Arrays.asList(5, 15, 25, 35));
        assertEquals(5, card.getNewPosition(35));
        assertEquals(5, card.getNewPosition(39));
        assertEquals(5, card.getNewPosition(0));
        assertEquals(5, card.getNewPosition(4));

        assertEquals(15, card.getNewPosition(5));
        assertEquals(15, card.getNewPosition(10));
        assertEquals(15, card.getNewPosition(14));

        assertEquals(25, card.getNewPosition(15));
        assertEquals(25, card.getNewPosition(16));
        assertEquals(25, card.getNewPosition(24));

        assertEquals(35, card.getNewPosition(25));
        assertEquals(35, card.getNewPosition(34));
    }

}