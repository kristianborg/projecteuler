package nl.krisborg.projecteuler;

import java.util.Set;

/**
 * User: kris
 * Date: 23-5-15
 */
public abstract class SudokuHelper {

    public static SudokuBoard solve(SudokuBoard board){
        populateMissing(board);
        if (board.isSolved()){
            return board;
        }

        if (!board.isValid()){
            return null;
        }

        for(int y = 0; y < board.BOARD_SIZE; y++){
            for(int x = 0; x < board.BOARD_SIZE; x++){
                if (!board.hasValue(x, y)){
                    Set<Integer> missing = board.getPossibleValues(x, y);
                    for (Integer value : missing) {
                        SudokuBoard guessedBoard = board.clone();
                        guessedBoard.setValue(x, y, value);
                        SudokuBoard solvedBoard = SudokuHelper.solve(guessedBoard);
                        if (solvedBoard != null){
                            return solvedBoard;
                        }
                    }
                    return null;
                }
            }
        }

        return null;
    }

    private static void populateMissing(SudokuBoard board){
        int changesInLastRound;
        do {
            changesInLastRound = 0;
            for(int y = 0; y < board.BOARD_SIZE; y++){
                for(int x = 0; x < board.BOARD_SIZE; x++){
                    if (board.hasValue(x, y)){
                        continue;
                    }

                    Set<Integer> missing = board.getPossibleValues(x, y);
                    if (missing.size() == 1){
                        board.setValue(x, y, missing.iterator().next());
                        changesInLastRound++;
                    }
                }
            }
        } while (changesInLastRound != 0);
    }
}
