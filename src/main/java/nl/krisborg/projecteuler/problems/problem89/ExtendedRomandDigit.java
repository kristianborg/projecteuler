package nl.krisborg.projecteuler.problems.problem89;

/**
 * Created by kris on 22-5-2015.
 */
public enum ExtendedRomandDigit implements RomanDigit {
    I(1),
    IV(4),
    V(5),
    IX(9),
    X(10),
    XL(40),
    L(50),
    XC(90),
    C(100),
    CD(400),
    D(500),
    CM(900),
    M(1000);

    private int value;

    ExtendedRomandDigit(int value){
        this.value = value;
    }

    public int getValue(){
        return value;
    }

    public boolean isComposed(){
        return toString().length() > 1;
    }

    public BasicRomanDigit getMainDigit() {
        String lastDigitString = this.toString().substring(this.toString().length() - 1);
        for(BasicRomanDigit d : BasicRomanDigit.values()){
            if (d.toString().equals(lastDigitString)){
                return d;
            }
        }

        throw new RuntimeException("not supposed to happen");
    }

    public BasicRomanDigit getPrefixDigit(){
        String firstDigitString = this.toString().substring(0, 1);
        for(BasicRomanDigit d : BasicRomanDigit.values()){
            if (d.toString().equals(firstDigitString)){
                return d;
            }
        }

        throw new RuntimeException("not supposed to happen");
    }
}
