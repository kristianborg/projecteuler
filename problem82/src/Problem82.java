/**
 * Created by kris on 3-5-2015.
 */
public class Problem82 {

    private int[][] input;
    private Pointer[][] pointerMatrix;

    public static void main(String[] argv){
        long before = System.currentTimeMillis();
        new Problem82().run();
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

        for (int x = input.length - 1; x >= 0; x--){
            for(int y = 0; y < input.length; y++){
                pointerMatrix[y][x].populate();
            }
        }

        int result = Integer.MAX_VALUE;
        for (int y = 0; y < input.length; y++){
            int currentResult = pointerMatrix[y][0].getShortestRoute();
            if (currentResult < result){
                result = currentResult;
                System.out.println("New shortest path from position " + y + ": " + currentResult);
            }
        }
        System.out.println("Shortest path: " + result);
    }
}
