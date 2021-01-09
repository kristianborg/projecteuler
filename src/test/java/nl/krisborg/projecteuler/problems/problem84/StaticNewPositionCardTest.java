package nl.krisborg.projecteuler.problems.problem84;

import junit.framework.TestCase;
import org.junit.Test;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class StaticNewPositionCardTest extends TestCase {

    @Test
    public void testIt(){
        StaticNewPositionCard card = new StaticNewPositionCard(1);
        assertEquals(1, card.getNewPosition(0));
        assertEquals(1, card.getNewPosition(39));
    }
}