package nl.krisborg.projecteuler.problems.problem84;

import junit.framework.TestCase;
import org.junit.Test;

/**
 * User: no88in
 * Date: 30-4-15
 */
public class BoardHelperTest extends TestCase {

    @Test
    public void testIt(){
        assertEquals(1, BoardHelper.moveOne(0));
        assertEquals(2, BoardHelper.moveOne(1));
        assertEquals(39, BoardHelper.moveOne(38));
        assertEquals(0, BoardHelper.moveOne(39));


        assertEquals(5, BoardHelper.move(0, 5));
        assertEquals(6, BoardHelper.move(1, 5));
        assertEquals(39, BoardHelper.move(34, 5));
        assertEquals(0, BoardHelper.move(35, 5));
        assertEquals(1, BoardHelper.move(36, 5));


        assertEquals(35, BoardHelper.move(0, -5));
    }

}