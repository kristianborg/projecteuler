package nl.krisborg.projecteuler;

import java.util.*;

/**
 * User: kris
 * Date: 22-5-15
 */
public class SudokuBoard implements Cloneable {

    public static final int BOARD_SIZE = 9;

    private int[][] board = new int[BOARD_SIZE][BOARD_SIZE];

    public SudokuBoard(int[][] board){
        this.board = board;
    }

    public SudokuBoard(int... values){
        if (values.length != BOARD_SIZE * BOARD_SIZE){
            throw new IllegalArgumentException("Invalid board");
        }

        for(int i = 0; i < values.length; i++){
            int x = i % BOARD_SIZE;
            int y = i / BOARD_SIZE;
            board[y][x] = values[i];
        }
    }

    public int getValue(int x, int y){
        return board[y][x];
    }

    public boolean hasValue(int x, int y){
        return board[y][x] != 0;
    }

    public void setValue(int x, int y, int value){
        board[y][x] = value;
    }

    public boolean isValid() {
        for (int i = 0; i < BOARD_SIZE; i++){
            int[] horizontalLine = extractHorizontalLine(i);
            int[] verticalLine = extractVerticalLine(i);
            int[] block = extractBlock(i);
            if (containsDoubles(horizontalLine) || containsDoubles(verticalLine) || containsDoubles(block)){
                return false;
            }
        }
        return true;
    }

    private boolean containsDoubles(int[] values){
        Set<Integer> seen = new HashSet<Integer>();
        for (int value : values) {
            if (value != 0){
                if (seen.contains(value)){
                    return true;
                } else {
                    seen.add(value);
                }
            }
        }
        return false;
    }

    public Set<Integer> getPossibleValues(int x, int y){
        int[] horizontalLine = extractHorizontalLine(y);
        int[] verticalLine = extractVerticalLine(x);
        int blockNr = ((y / 3) * 3) + x / 3;
        int[] block = extractBlock(blockNr);
        return findMissing(horizontalLine, verticalLine, block);
    }

    private Set<Integer> findMissing(int[] values1, int[] values2, int[] values3) {
        Set<Integer> result = new HashSet<Integer>(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9));
        for (int value : values1) {
            result.remove(value);
        }
        for (int value : values2) {
            result.remove(value);
        }
        for (int value : values3) {
            result.remove(value);
        }
        return result;
    }

    public int[] extractHorizontalLine(int y) {
        int[] result = new int[BOARD_SIZE];
        for(int x = 0; x < BOARD_SIZE; x++){
            result[x] = getValue(x, y);
        }
        return result;
    }

    public int[] extractVerticalLine(int x) {
        int[] result = new int[BOARD_SIZE];
        for(int y = 0; y < BOARD_SIZE; y++){
            result[y] = getValue(x, y);
        }
        return result;
    }

    public int[] extractBlock(int block) {
        int[] result = new int[BOARD_SIZE];
        for(int i = 0; i < BOARD_SIZE; i++){
            int x = (block % 3) * 3 + (i % 3);
            int y = (block / 3) * 3 + (i / 3);
            result[i] = getValue(x, y);
        }
        return result;
    }

    public boolean isSolved() {
        for (int[] values : board) {
            for (int value : values) {
                if (value == 0){
                    return false;
                }
            }
        }

        return true;
    }

    public String toString() {
        String result = "";
        for(int y = 0; y < BOARD_SIZE; y++){
            if (y == 3 || y == 6){
                result += "---------------------\n";
            }
            for(int x = 0; x < BOARD_SIZE; x++){
                result += board[y][x] + " ";
                if (x == 2 || x == 5){
                    result += "| ";
                }

                if (x == 8){
                    result += "\n";
                }
            }
        }
        result += "=====================\n";
        return result;
    }

    public SudokuBoard clone(){
        int[][] clone = new int[BOARD_SIZE][BOARD_SIZE];
        for (int x = 0; x < BOARD_SIZE; x++){
            for (int y = 0; y < BOARD_SIZE; y++){
                clone[y][x] = board[y][x];
            }
        }
        return new SudokuBoard(clone);
    }

    public int getTopLeftNumber() {
        return 100 * board[0][0] + 10 * board[0][1] + board[0][2];
    }
}
