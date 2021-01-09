package nl.krisborg.projecteuler.problems.problem89;

/**
 * Created by kris on 22-5-2015.
 */
public interface RomanDigit {

    int getValue();

    boolean isComposed();

    BasicRomanDigit getMainDigit();

    BasicRomanDigit getPrefixDigit();
}
