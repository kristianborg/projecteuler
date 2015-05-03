package nl.krisborg.projecteuler;

import junit.framework.TestCase;
import org.junit.Test;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class BackXPositiontsCardTest extends TestCase {

    @Test
    public void testIt(){
        BackXPositiontsCard card = new BackXPositiontsCard(3);
        assertEquals(37, card.getNewPosition(0));
        assertEquals(38, card.getNewPosition(1));
        assertEquals(39, card.getNewPosition(2));
        assertEquals(0, card.getNewPosition(3));
        assertEquals(1, card.getNewPosition(4));
    }


}