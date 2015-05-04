/**
 * Created by kris on 3-5-2015.
 */
public class Pointer {

    private Pointer up;
    private Pointer down;
    private Pointer right;
    private int value;
    private Integer shortestRoute = null;
    String shortestRouteDirection = null;

    Pointer(int value) {
        this.value = value;
    }

    public void populate() {
        if (right == null) {
            shortestRoute = value;
            return;
        }

        shortestRoute = right.getShortestRoute();
        shortestRouteDirection = "right";

        if (up != null){
            int currentDistanceGoingUp = 0;
            Pointer nextUp = up;
            while (nextUp != null){
                currentDistanceGoingUp += nextUp.getValue();
                int totalDistanceCurrentRoute = currentDistanceGoingUp + nextUp.getRight().getShortestRoute();
                if (totalDistanceCurrentRoute < shortestRoute){
                    shortestRoute = totalDistanceCurrentRoute;
                    shortestRouteDirection = "up";
                }
                nextUp = nextUp.getUp();
            }
        }

        if (down != null){
            Pointer nextDown = down;
            int currentDistanceGoingDown = 0;
            while (nextDown != null){
                currentDistanceGoingDown += nextDown.getValue();
                int totalDistanceCurrentRoute = currentDistanceGoingDown + nextDown.getRight().getShortestRoute();
                if (totalDistanceCurrentRoute < shortestRoute){
                    shortestRoute = totalDistanceCurrentRoute;
                    shortestRouteDirection = "down";
                }
                nextDown = nextDown.getDown();
            }
        }

        shortestRoute += value;
    }

    public Pointer getUp() {
        return up;
    }

    public void setUp(Pointer up) {
        this.up = up;
    }

    public Pointer getDown() {
        return down;
    }

    public void setDown(Pointer down) {
        this.down = down;
    }

    public Pointer getRight() {
        return right;
    }

    public void setRight(Pointer right) {
        this.right = right;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public Integer getShortestRoute() {
        return shortestRoute;
    }
}
