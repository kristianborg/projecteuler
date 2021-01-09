package nl.krisborg.projecteuler.problems.problem89;

/**
 * User: no88in
 * Date: 21-5-15
 */

import java.util.List;

public class RomanNumberProcessor {

    public static void main(String[] argv){
        int totalSaved = 0;
        for(String s : InputHelper.getInput()){
            totalSaved += solve(s);
        }
        System.out.println("Total saved: " + totalSaved);
    }

    public static int solve(String roman){
        BasicRomanDigit[] romanDigits = new BasicRomanDigit[roman.length()];
        int i = 0;
        for (Character c : roman.toCharArray()){
            romanDigits[i] = getRomanDigit(c.toString());
            i++;
        }
        RomanNumber<BasicRomanDigit> number = new RomanNumber<BasicRomanDigit>(romanDigits);

        int intValue = RomanNumberHelper.getIntValue(number);
        List<String> romanNumberStrings = RomanNumberHelper.getShortestRomanNumbers(intValue);
        int digitsSaved = roman.length() - romanNumberStrings.get(0).length();

        System.out.println(roman + " = " + intValue + " = " + romanNumberStrings.get(romanNumberStrings.size() - 1) + ". Saves: " + digitsSaved);

        return digitsSaved;
    }

    private static BasicRomanDigit getRomanDigit(String s) {
        for(BasicRomanDigit d : BasicRomanDigit.values()){
            if (d.toString().equalsIgnoreCase(s)){
                return d;
            }
        }
        throw new RuntimeException("not supposed to happen");
    }
}
