package nl.krisborg.projecteuler.problems.problem84;

import static nl.krisborg.projecteuler.problems.problem84.Constants.BOARD_SIZE;
import static nl.krisborg.projecteuler.problems.problem84.Constants.C1;
import static nl.krisborg.projecteuler.problems.problem84.Constants.CHANCE_POSITIONS;
import static nl.krisborg.projecteuler.problems.problem84.Constants.COMMUNICY_CHEST_POSITIONS;
import static nl.krisborg.projecteuler.problems.problem84.Constants.DICE_SIDES;
import static nl.krisborg.projecteuler.problems.problem84.Constants.E3;
import static nl.krisborg.projecteuler.problems.problem84.Constants.GO;
import static nl.krisborg.projecteuler.problems.problem84.Constants.GO_TO_JAIL;
import static nl.krisborg.projecteuler.problems.problem84.Constants.H2;
import static nl.krisborg.projecteuler.problems.problem84.Constants.JAIL;
import static nl.krisborg.projecteuler.problems.problem84.Constants.MAX_CONSEQUETIVE_DOUBLES;
import static nl.krisborg.projecteuler.problems.problem84.Constants.R1;
import static nl.krisborg.projecteuler.problems.problem84.Constants.RAILWAY_POSITIONS;
import static nl.krisborg.projecteuler.problems.problem84.Constants.RANDOM;
import static nl.krisborg.projecteuler.problems.problem84.Constants.UTILITY_POSITIONS;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * User: no88in
 * Date: 29-4-15
 */
public class Problem84 {

    protected CardStack communityChestCards;
    protected CardStack chanceCards;
    protected int currentPosition = 0;
    int currentDoubleStreakSize = 0;
    int numThrows = 100000000;
    int[] positionOccurences = new int[BOARD_SIZE];

    private void go(){
        communityChestCards = createCommunityChestCards();
        chanceCards = createChanceCards();
        for (int i = 0; i < numThrows; i++) {
            play();
            positionOccurences[currentPosition]++;
        }
        printStatistics();
    }

    private void printStatistics() {
        System.out.println("============== STATISTICS ==============");
        List<PositionOccurence> occurences = new ArrayList<PositionOccurence>();
        for(int i = 0; i <BOARD_SIZE; i++){
            PositionOccurence occurence = new PositionOccurence(i, numThrows, positionOccurences[i]);
            occurences.add(occurence);
            System.out.println("" + occurence.getBoardPosition() + ": " + positionOccurences[i] + " (" + occurence.getPercentage() + "% )");
        }
        Collections.sort(occurences);
        System.out.println("============== STATISTICS ==============");
        System.out.println("Result: " + occurences.get(39).getBoardPosition() + occurences.get(38).getBoardPosition() + occurences.get(37).getBoardPosition());
    }


    protected void play(){
        // roll dice
        int dice1 = throwDice();
        int dice2 = throwDice();
        int diceValue = dice1 + dice2;
        log("Dice throws " + dice1 + " + " + dice2 + " = " + diceValue);

        // count doubles
        if (dice1 == dice2){
            currentDoubleStreakSize += 1;
        } else {
            currentDoubleStreakSize = 0;
        }

        // send to jail if too many doubles
        if (currentDoubleStreakSize > MAX_CONSEQUETIVE_DOUBLES){
            log("=========== too many doubles; going to jail");
            currentPosition = JAIL;
            currentDoubleStreakSize = 0;
            return;
        }

        // move piece
        currentPosition = BoardHelper.move(currentPosition, diceValue);
        log("New position: " + currentPosition);

        // special field logic
        if (currentPosition == GO_TO_JAIL){
            log("=========== ended on GO-TO-JAIL");
            currentPosition = JAIL;
        } else if (CHANCE_POSITIONS.contains(currentPosition)) {
            Card chCard = chanceCards.pickCard();
            currentPosition = chCard.getNewPosition(currentPosition);
            log("=========== Chance card " + chCard.getName() + " sends to " + currentPosition);
        } else if (COMMUNICY_CHEST_POSITIONS.contains(currentPosition)){
            Card ccCard = communityChestCards.pickCard();
            currentPosition = ccCard.getNewPosition(currentPosition);
            log("=========== Community Chest card " + ccCard.getName() + " sends to " + currentPosition);
        }

        // check state after special field
        if (currentPosition == GO_TO_JAIL) {
            log("=========== ended on GO-TO-JAIL");
            currentPosition = JAIL;
        }
    }

    protected int throwDice() {
        return RANDOM.nextInt(DICE_SIDES) + 1;
    }

    private CardStack createChanceCards() {
        CardStack result = new CardStack();
        result.addCard(new StaticNewPositionCard(GO));
        result.addCard(new StaticNewPositionCard(JAIL));
        result.addCard(new StaticNewPositionCard(C1));
        result.addCard(new StaticNewPositionCard(E3));
        result.addCard(new StaticNewPositionCard(H2));
        result.addCard(new StaticNewPositionCard(R1));
        result.addCard(new ClosestNextPositionCard(RAILWAY_POSITIONS));
        result.addCard(new ClosestNextPositionCard(RAILWAY_POSITIONS));
        result.addCard(new ClosestNextPositionCard(UTILITY_POSITIONS));
        result.addCard(new BackXPositiontsCard(3));
        for (int i = 0; i < 6; i++){
            result.addCard(new VoidCard());
        }
        return result;
    }

    private CardStack createCommunityChestCards() {
        CardStack result = new CardStack();
        result.addCard(new StaticNewPositionCard(GO));
        result.addCard(new StaticNewPositionCard(JAIL));
        for (int i = 0; i < 14; i++){
            result.addCard(new VoidCard());
        }
        return result;
    }

    private void log(String s){
        // System.out.println(s);
    }

    public static void main(String[] argv){
        new Problem84().go();
    }
}
