package nl.krisborg.projecteuler.problems.problem83;

/**
 * Created by kris on 3-5-2015.
 */
public class Pointer {
    private Pointer up;
    private Pointer down;
    private Pointer left;
    private Pointer right;
    private int value;
    private Integer shortestRoute = null;
    String shortestRouteDirection = null;

    Pointer(int value) {
        this.value = value;
    }

    public String getSolutionRoute(){
        if (shortestRouteDirection == null){
            return "here";
        }

        String result = shortestRouteDirection + " ";
        if (shortestRouteDirection.equals("up")){
            result += up.getSolutionRoute();
        }

        if (shortestRouteDirection.equals("down")){
            result += down.getSolutionRoute();
        }

        if (shortestRouteDirection.equals("left")){
            result += left.getSolutionRoute();
        }

        if (shortestRouteDirection.equals("right")){
            result += right.getSolutionRoute();
        }

        return result;
    }

    public void update() {
        if (right == null && down == null) {
            shortestRoute = value;
            return;
        }

        shortestRoute = Integer.MAX_VALUE;

        if (left != null && left.getShortestRoute() != null){
            int shortestRouteViaLeft = left.getShortestRoute();
            if (shortestRoute == null || shortestRouteViaLeft < shortestRoute){
                shortestRoute = shortestRouteViaLeft;
                shortestRouteDirection = "left";
            }
        }

        if (right != null && right.getShortestRoute() != null){
            int shortestRouteViaRight = right.getShortestRoute();
            if (shortestRoute == null || shortestRouteViaRight < shortestRoute){
                shortestRoute = shortestRouteViaRight;
                shortestRouteDirection = "right";
            }
        }

        if (up != null && up.getShortestRoute() != null){
            int shortestRouteViaUp = up.getShortestRoute();
            if (shortestRoute == null || shortestRouteViaUp < shortestRoute){
                shortestRoute = shortestRouteViaUp;
                shortestRouteDirection = "up";
            }
        }

        if (down != null && down.getShortestRoute() != null){
            int shortestRouteViaDown = down.getShortestRoute();
            if (shortestRoute == null || shortestRouteViaDown < shortestRoute){
                shortestRoute = shortestRouteViaDown;
                shortestRouteDirection = "down";
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

    public void setLeft(Pointer left) {
        this.left = left;
    }
}
