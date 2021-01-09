package nl.krisborg.projecteuler.problems.problem89;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * User: no88in
 * Date: 21-5-15
 */
public class RomanNumber<T extends RomanDigit> {

    private List<T> digits;

    public RomanNumber(T... romandDigits){
        digits = Arrays.asList(romandDigits);
    }

    public List<T> getDigits() {
        return clone(digits);
    }

    private List<T> clone(List<T> digits) {
        List<T> result = new ArrayList<T>();
        for (T digit : digits) {
            result.add(digit);
        }
        return result;
    }
}
