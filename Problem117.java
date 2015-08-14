import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Problem117 {
	
	private List<Integer>blockSizes = Arrays.asList(2, 3, 4); 
	private Map<Integer, Long> cache = new HashMap<Integer, Long>();
	private static final int NUM_TILES = 50;
	
	public void solve(){
		long result = getPermutations(NUM_TILES);
		System.out.println("Result : " + result);
	}
	
	private long getPermutations(int totalSize){
		long result = 0;
		if (totalSize == 0){
			result = 1;
		} else if (cache.containsKey(totalSize)){
			return cache.get(totalSize);
		} else {
			result += getPermutations(totalSize - 1);
			for(int blockSize : blockSizes){
				if (blockSize <= totalSize){
					result += getPermutations(totalSize - blockSize);
				}
			}
			cache.put(totalSize, result);
		}
		
		return result;
	}
	
	public static void main(String[] argv){
		new Problem117().solve();
	}

}
