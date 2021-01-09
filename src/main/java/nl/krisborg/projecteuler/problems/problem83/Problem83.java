package nl.krisborg.projecteuler.problems.problem83;

/**
 * Created by kris on 3-5-2015.
 */
public class Problem83 {

    private int[][] input;
    private Pointer[][] pointerMatrix;

    public static void main(String[] argv){
        long before = System.currentTimeMillis();
        new Problem83().run();
        long after = System.currentTimeMillis();
        System.out.println("Computation took " + (after - before) + "ms");
    }

    public void run(){
        input = Matrix.getInput();
        pointerMatrix = new Pointer[input.length][input.length];
        for (int x = 0; x < input.length; x++){
            for (int y = 0; y < input.length; y++){
                Pointer p = new Pointer(input[y][x]);
                pointerMatrix[y][x] = p;
            }
        }

        for (int x = 0; x < input.length; x++){
            for (int y = 0; y < input.length; y++){
                Pointer p = pointerMatrix[y][x];
                if (x != 0){
                    Pointer left = pointerMatrix[y][x - 1];
                    p.setLeft(left);
                }

                if (x != input.length - 1){
                    Pointer right = pointerMatrix[y][x + 1];
                    p.setRight(right);
                }

                if (y != 0){
                    Pointer up = pointerMatrix[y - 1][x];
                    p.setUp(up);;
                }

                if (y != input.length - 1){
                    Pointer down = pointerMatrix[y + 1][x];
                    p.setDown(down);
                }
            }
        }

        int iterations = input.length;

        for (int i = 0; i < iterations; i++) {
            for (int x = input.length - 1; x >= 0; x--) {
                for (int y = input.length - 1; y >= 0; y--) {
                    pointerMatrix[y][x].update();
                }
            }

            System.out.println("Shortest distence after iteration " + (i + 1) + ": " + pointerMatrix[0][0].getShortestRoute() + " " + pointerMatrix[0][0].getSolutionRoute());
        }
    }
}
