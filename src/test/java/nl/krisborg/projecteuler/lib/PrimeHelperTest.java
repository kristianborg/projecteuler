package nl.krisborg.projecteuler.lib;

import static org.junit.Assert.assertEquals;

import nl.krisborg.projecteuler.lib.PrimeHelper.EUAResult;
import org.junit.Test;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class PrimeHelperTest {

    @Test
    public void testGetPrimes() {
        assertEquals(Collections.emptyList(), PrimeHelper.getPrimes(0));
        assertEquals(Collections.emptyList(), PrimeHelper.getPrimes(1));
        assertEquals(Arrays.asList(2), PrimeHelper.getPrimes(2));
        assertEquals(Arrays.asList(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89), PrimeHelper.getPrimes(96));
        assertEquals(Arrays.asList(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97), PrimeHelper.getPrimes(97));
        assertEquals(Arrays.asList(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97), PrimeHelper.getPrimes(98));
    }

    @Test
    public void testExtendedEuclideanAlgorithm() {
        assertEquals(new EUAResult(10, 1, -1), PrimeHelper.extendedEuclideanAlgorithm(30, 20));
        assertEquals(new EUAResult(1, -1, 3), PrimeHelper.extendedEuclideanAlgorithm(23, 8));
    }

    @Test
    public void testGetGcd() {
        assertEquals(6, PrimeHelper.getGcd(270, 192));
    }

    @Test
    public void testGetPrimeFactors() {
        assertEquals(Arrays.asList(2), PrimeHelper.getPrimeFactors(2));
        assertEquals(Arrays.asList(101), PrimeHelper.getPrimeFactors(101));
        assertEquals(Arrays.asList(2, 3), PrimeHelper.getPrimeFactors(2 * 3));
        assertEquals(Arrays.asList(2, 3, 5, 7, 11), PrimeHelper.getPrimeFactors(2 * 3 * 5 * 7 * 11));
        assertEquals(Arrays.asList(2, 2, 2, 11, 11), PrimeHelper.getPrimeFactors(2 * 2 * 2 * 11 * 11));
        assertEquals(Arrays.asList(13397, 13399, 13411), PrimeHelper.getPrimeFactors((long) 13397 * 13399 * 13411));
    }
}