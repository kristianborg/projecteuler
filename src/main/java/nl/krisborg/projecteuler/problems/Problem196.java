package nl.krisborg.projecteuler.problems;

import static java.util.stream.Collectors.toList;

import lombok.Data;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class Problem196 {

  public static void main(String[] args) {
    new Problem196().solve(5678027, 7208785);
  }

  public void solve(long... rowNums) {
    long before = System.currentTimeMillis();

    long result = 0;
    for (long rowNum : rowNums) {

      System.out.println("Processing: " + rowNum);
      List<TriangleCoordinate> rowItems = getRow(rowNum);

      long subResult = 0;
      for (TriangleCoordinate rowItem : rowItems) {
        if (rowItem.isProbablyPrimeTriple()) {
//          System.out.println("part of prime triple: " + rowItem.getValue());
          subResult += rowItem.getValue();
        }
      }
      System.out.println("Subresult: " + subResult);
      result += subResult;
    }

    long time = System.currentTimeMillis() - before;
    System.out.println();
    System.out.println("result: " + result);
    System.out.println("time: " + time);
  }

  private List<TriangleCoordinate> getRow(long rowNum) {
    List<TriangleCoordinate> result = new ArrayList<>();
    for (int columnNum = 0; columnNum < rowNum; columnNum++) {
      result.add(new TriangleCoordinate(rowNum, columnNum));
    }
    return result;
  }

  @Data
  class TriangleCoordinate {

    private final long row;
    private final int column;
    private Long value = null;

    public TriangleCoordinate(long row, int column) {
      this.row = row;
      this.column = column;
      if (row >= 0 && column >= 0 && column < row) {
        value = (row * (row - 1)) / 2 + 1 + column;
      }
    }

    public TriangleCoordinate getNeighbourNW() {
      return new TriangleCoordinate(row - 1, column - 1);
    }

    public TriangleCoordinate getNeighbourN() {
      return new TriangleCoordinate(row - 1, column);
    }

    public TriangleCoordinate getNeighbourNE() {
      return new TriangleCoordinate(row - 1, column + 1);
    }

    public TriangleCoordinate getNeighbourE() {
      return new TriangleCoordinate(row, column + 1);
    }

    public TriangleCoordinate getNeighbourSE() {
      return new TriangleCoordinate(row + 1, column + 1);
    }

    public TriangleCoordinate getNeighbourS() {
      return new TriangleCoordinate(row + 1, column);
    }

    public TriangleCoordinate getNeighbourSW() {
      return new TriangleCoordinate(row + 1, column - 1);
    }

    public TriangleCoordinate getNeighbourW() {
      return new TriangleCoordinate(row, column - 1);
    }

    public boolean isProbablyPrimeTriple() {
      return isProbablyPrimeTriple(4) && isProbablyPrimeTriple(1000);
    }

    private boolean isProbablyPrimeTriple(int certainty) {

      // if the current number is not prime it certainly isn't part of a prime tripple
      if (!isProbablyPrime(certainty)) {
        return false;
      }

      List<TriangleCoordinate> probablyPrimeNeighbours = getProbablyPrimeNeighbours(certainty);

      // if none of the neighbors is prime we are the only prime, so not part of a prime tripple
      if (probablyPrimeNeighbours.isEmpty()) {
        return false;
      }

      // if 2 or more neighbours are prime we are certainly part of a prime tripple
      if (probablyPrimeNeighbours.size() >= 2) {
        return true;
      }

      // if we end up here only one neighbour is prime. In that case we are part of a prime tripple if that neighbour has at least one other neighbor (besides us) which is prime.
      return probablyPrimeNeighbours.get(0).getProbablyPrimeNeighbours(certainty).size() >= 2;
    }

    private boolean isProbablyPrime(int certainty) {
      return value != null && BigInteger.valueOf(value).isProbablePrime(certainty);
    }

    public List<TriangleCoordinate> getProbablyPrimeNeighbours(int certainty) {
      return getAllNeighbours().stream()
          .filter(neighbour -> neighbour.isProbablyPrime(certainty))
          .collect(toList());
    }

    private List<TriangleCoordinate> getAllNeighbours() {
      List<TriangleCoordinate> result = new ArrayList<>();
      addIfNotNull(result, getNeighbourNW());
      addIfNotNull(result, getNeighbourN());
      addIfNotNull(result, getNeighbourNE());
      addIfNotNull(result, getNeighbourE());
      addIfNotNull(result, getNeighbourSE());
      addIfNotNull(result, getNeighbourS());
      addIfNotNull(result, getNeighbourSW());
      addIfNotNull(result, getNeighbourW());
      return result;
    }

    private void addIfNotNull(List<TriangleCoordinate> items, TriangleCoordinate item) {
      if (item != null && item.getValue() != null) {
        items.add(item);
      }
    }
  }
}
