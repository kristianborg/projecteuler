package nl.krisborg.projecteuler.problems.problem89;

/**
 * User: no88in
 * Date: 21-5-15
 */
public enum BasicRomanDigit implements RomanDigit {
    I(1),
    V(5),
    X(10),
    L(50),
    C(100),
    D(500),
    M(1000);

    private int value;

    BasicRomanDigit(int value){
        this.value = value;
    }

    public int getValue(){
        return value;
    }

    public boolean isComposed(){
        return false;
    }

    public BasicRomanDigit getMainDigit(){
        return this;
    }

    public BasicRomanDigit getPrefixDigit(){
        throw new RuntimeException("Not supposed to happen");
    }
}
