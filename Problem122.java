import java.util.ArrayList;

public class Problem122 {
	
	public void solve(int min, int max){
		int sum = 0;
		for (int val = min; val <= max; val++){
			int maxDepth = getMax(val);
			ArrayList<Integer> allComponents = new ArrayList<Integer>();
			allComponents.add(1);
			ArrayList<Integer> uniqueComponents = new ArrayList<Integer>();
			uniqueComponents.add(1);
			ArrayList<Integer> composition = decompose(val, 1, maxDepth - 1, allComponents, uniqueComponents);
			if (composition != null){
				System.out.println("Optimum composition of " + val + " contains " + (composition.size() - 1) + " values: " + composition.toString() + " (binary result: " + maxDepth + ")");
				sum += (composition.size() - 1);
			} else {
				System.out.println("Optimum composition of " + val + " is default binary method result: " + maxDepth);
				sum += maxDepth;
			}
		}
		System.out.println("Result: " + sum);
	}
	
	private ArrayList<Integer> decompose(int targetValue, int currentValue, int maxDepth, ArrayList<Integer> allComponents, ArrayList<Integer> uniqueComponents){
		ArrayList<Integer> result;
		if (targetValue == currentValue){
			result = uniqueComponents;
		} else if (allComponents.size() > maxDepth){
			result = null;
		} else {
			result = null;
			for(int existingComponent : uniqueComponents){
				int newMaxDepth = result == null ? maxDepth : result.size() - 1;
				if (existingComponent > currentValue){
					break;
				}
				int newCurrentValue = currentValue + existingComponent;
				ArrayList<Integer> newAllComponents = (ArrayList)allComponents.clone();
				newAllComponents.add(existingComponent);
				ArrayList<Integer> newUniqueComponents = (ArrayList)uniqueComponents.clone();
				newUniqueComponents.add(newCurrentValue);
				ArrayList<Integer> resultCandidate = decompose(targetValue, newCurrentValue, newMaxDepth, newAllComponents, newUniqueComponents);
				if (resultCandidate != null){
					if (result == null || resultCandidate.size() < result.size()){
						result = resultCandidate;
					}
				}
			}
		}
		return result;
	}

	private int getMax(int i) {
		int powTwoExp = getMaxPowTwoExp(i);
		int powTwo = (int)Math.pow(2, powTwoExp);
		int result = powTwoExp;
		i -= powTwo;
		while(i != 0){
			result++;
			powTwoExp = getMaxPowTwoExp(i);
			powTwo = (int)Math.pow(2, powTwoExp);
			i -= powTwo;
		}
		return result;
	}
	
	private int getMaxPowTwoExp(int i){
		return (int)(Math.log(i) / Math.log(2));
	}
	
	public static void main(String[] argv){
		new Problem122().solve(1, 200);
	}
}
