package nl.krisborg.projecteuler;

import java.util.List;

/**
 * User: kris
 * Date: 22-5-15
 */
public class SudokySolver {

    public static void main(String[] argv){
        List<SudokuBoard> boards = InputHelper.getInput();
        int result = 0;
        for (SudokuBoard board : boards) {
            System.out.println("Input:");
            System.out.println(board.toString());
            SudokuBoard solvedBoard = SudokuHelper.solve(board);
            if (solvedBoard == null){
                throw new RuntimeException("huh?");
            }
            System.out.println("Solution:");
            System.out.println(solvedBoard.toString());
            result += solvedBoard.getTopLeftNumber();
        }
        System.out.println("Result: " + result);
    }
}
