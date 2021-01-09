package nl.krisborg.projecteuler.problems.problem84;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

/**
 * User: no88in
 * Date: 29-4-15
 */
public class Constants {

    public static final int DICE_SIDES = 4;
    public static final int BOARD_SIZE = 40;
    public static final Random RANDOM = new Random(0);
    public static final int MAX_CONSEQUETIVE_DOUBLES = 2;


    // misc board positions
    public static final int GO = 0;
    public static final int JAIL = 10;
    public static final int C1 = 11;
    public static final int E3 = 24;
    public static final int GO_TO_JAIL = 30;
    public static final int H2 = 39;

    // railways
    public static final int R1 = 5;
    public static final int R2 = 15;
    public static final int R3 = 25;
    public static final int R4 = 35;

    // utility stations
    private static final int U1 = 12;
    private static final int U2 = 28;

    // community chest
    private static final int CC1 = 2;
    private static final int CC2 = 17;
    private static final int CC3 = 33;

    // chance
    private static final int CH1 = 7;
    private static final int CH2 = 22;
    private static final int CH3 = 36;


    public static final List<Integer> COMMUNICY_CHEST_POSITIONS = Arrays.asList(CC1, CC2, CC3);
    public static final List<Integer> CHANCE_POSITIONS = Arrays.asList(CH1, CH2, CH3);
    public static final List<Integer> RAILWAY_POSITIONS = Arrays.asList(R1, R2, R3, R4);
    public static final List<Integer> UTILITY_POSITIONS = Arrays.asList(U1, U2);
}
