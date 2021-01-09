package nl.krisborg.projecteuler.problems.problem54;


import nl.krisborg.projecteuler.problems.problem54.gameobjects.Card;
import nl.krisborg.projecteuler.problems.problem54.hands.Hand;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by kris on 1-5-2015.
 */
public class Problem54 {

    public static void main(String[] argv){
        new Problem54().run();
    }

    private void run() {
        String[] inputData = getInputData();
        List<Hand[]> games = extractGames(inputData);
        int playerOneWins = 0;
        int playerTwoWins = 0;
        for (Hand[] hands : games) {
            Hand playerOneHand = hands[0];
            Hand playerTwoHand = hands[1];
            int diff = playerOneHand.compareTo(playerTwoHand);
            if (diff == 0){
                throw new IllegalArgumentException("Game ends in tie");
            }
            if (diff > 0){
                System.out.println("Player 1 wins: " + playerOneHand.toString() + " vs " + playerTwoHand.toString());
                playerOneWins++;
            } else {
                System.out.println("Player 2 wins: " + playerOneHand.toString() + " vs " + playerTwoHand.toString());
                playerTwoWins++;
            }
        }
        System.out.println("==============================");
        System.out.println("Wins Player One: " + playerOneWins);
        System.out.println("Wins Player Two: " + playerTwoWins);
    }

    private List<Hand[]> extractGames(String[] gameStrings) {
        List<Hand[]> result = new ArrayList<Hand[]>();
        for (String gameString : gameStrings) {
            String[] cardStrings = gameString.split(" ");
            if (cardStrings.length != 10){
                throw new IllegalArgumentException("Unexpected number of cards: " + cardStrings.length);
            }
            List<Card> playerOneCards = new ArrayList<Card>();
            for (int i = 0; i < 5; i++){
                playerOneCards.add(new Card(cardStrings[i]));
            }
            Hand playerOneHand = HandHelper.getHighestHand(playerOneCards);

            List<Card> playerTwoCards = new ArrayList<Card>();
            for (int i = 5; i < 10; i++){
                playerTwoCards.add(new Card(cardStrings[i]));
            }
            Hand playerTwoHand = HandHelper.getHighestHand(playerTwoCards);

            result.add(new Hand[]{playerOneHand, playerTwoHand});
        }
        return result;
    }

    private String[] getInputData(){
        return InputData.getInputData();
        /*return new String[]{
                "5H 5C 6S 7S KD 2C 3S 8S 8D TD",
                "5D 8C 9S JS AC 2C 5C 7D 8S QH",
                "2D 9C AS AH AC 3D 6D 7D TD QD",
                "4D 6S 9H QH QC 3D 6D 7H QD QS",
                "2H 2D 4C 4D 4S 3C 3D 3S 9S 9D"};*/
    }
}
