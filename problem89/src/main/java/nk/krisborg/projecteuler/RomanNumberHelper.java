package nk.krisborg.projecteuler;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import static nk.krisborg.projecteuler.BasicRomanDigit.*;

/**
 * Created by kris on 22-5-2015.
 */
public abstract class RomanNumberHelper {

    private static final List<BasicRomanDigit> ALLOWED_ONCE = Arrays.asList(D, L, V);

    public static int getIntValue(RomanNumber romanNumber){
        List<RomanDigit> digits = romanNumber.getDigits();
        int result = 0;
        while (!digits.isEmpty()){
            List<RomanDigit> group = extractGroup(digits);
            result += getGroupValue(group);
            for (int i = 0; i < group.size(); i++){
                digits.remove(0);
            }
        }
        return result;
    }

    public static List<String> getShortestRomanNumbers(int number){
        int numMPrefixes = number / 1000;
        List<String> romanNumberStrings = extractRomanNumbers(number - numMPrefixes * 1000, ExtendedRomandDigit.M);
        int shortestNumber = Integer.MAX_VALUE;
        for (String romanNumberString : romanNumberStrings) {
            if (romanNumberString.length() < shortestNumber){
                shortestNumber = romanNumberString.length();
            }
        }

        String prefix = "";
        for (int i = 0; i < numMPrefixes; i++){
            prefix += "M";
        }
        List<String> result = new ArrayList<String>();
        for (String romanNumberString : romanNumberStrings) {
            if (romanNumberString.length() == shortestNumber) {
                result.add(prefix + romanNumberString);
            }
        }

        return result;
    }

    private static List<String> extractRomanNumbers(int number, ExtendedRomandDigit last){
        List<String> result = new ArrayList<String>();
        if (number == 0){
            return Arrays.asList("");
        }

        for (ExtendedRomandDigit current : ExtendedRomandDigit.values()){
            if (current.getValue() > number){
                continue;
            }

            // check descending value rule
            if (current.getValue() > last.getValue()){
                continue;
            }

            // things like IXIX / IXIIX can always be expressed in an other wasy
            if (last.isComposed() && current.isComposed() && last.getMainDigit() == current.getMainDigit()){
                continue;
            }

            // this like IXI can always be expressed in other, shorter ways
            if (last.isComposed() && !current.isComposed() && last.getPrefixDigit() == current.getMainDigit()){
                continue;
            }

            // things like XXXX can always be expressed in other ways
            if (number / current.getValue() > 3){
                continue;
            }

            if (current.getValue() <= last.getValue() && current.getValue() <= number){
                List<String> subRomanNumbers = extractRomanNumbers(number - current.getValue(), current);
                for (String subRomanNumber : subRomanNumbers) {

                    if (ALLOWED_ONCE.contains(current.getMainDigit()) && subRomanNumber.contains(current.getMainDigit().toString())){
                        // skip; D, L, and V can each only appear once.
                    } else {
                        result.add(current.toString() + subRomanNumber);
                    }
                }
            }
        }
        return result;
    }

    private static List<RomanDigit> extractGroup(List<RomanDigit> digitsClone) {
        List<RomanDigit> result = new ArrayList<RomanDigit>();
        RomanDigit previous = null;
        for (RomanDigit digit : digitsClone) {
            if (previous == null){
                // include this one and keep going
                result.add(digit);
            } else if (digit.getValue() > previous.getValue()){
                // include this one and we're done
                result.add(digit);
                break;
            } else if (digit.getValue() == previous.getValue()){
                // add this one and keep going
                result.add(digit);
            } else if (digit.getValue() < previous.getValue()){
                // don't include this one and we're done
                break;
            } else {
                throw new RuntimeException("We were not supposed to get here");
            }
            previous = digit;
        }
        return result;
    }

    private static int getGroupValue(List<RomanDigit> digits){
        RomanDigit lastDigit = digits.get(digits.size() - 1);
        int result = 0;
        for (RomanDigit digit : digits) {
            if (digit.getValue() == lastDigit.getValue()){
                result += digit.getValue();
            } else if (digit.getValue() < lastDigit.getValue()){
                result -= digit.getValue();
            } else {
                throw new RuntimeException("We were not supposed to get here");
            }
        }

        if (result <= 0){
            throw new RuntimeException("We were not supposed to get here");
        }

        return result;
    }
}
