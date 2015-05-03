package nl.krisborg.projecteuler;

import junit.framework.TestCase;
import org.junit.Test;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class VoidCardTest extends TestCase {

    @Test
    public void testIt(){
        VoidCard card = new VoidCard();
        assertEquals(0, card.getNewPosition(0));
        assertEquals(10, card.getNewPosition(10));
    }
}