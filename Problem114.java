import java.util.HashMap;
import java.util.Map;

public class Problem114 {
	 
	private Map<Integer, Long> cache = new HashMap<Integer, Long>();
	private static final int NUM_TILES = 50;
	private static final int MIN_BLOCK_SIZE = 3;
	
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
			result += getPermutations(totalSize - 1); // black block
			if (totalSize >= MIN_BLOCK_SIZE){
				result += 1; // completely filling remaining space
			}
			for (int blockSize = MIN_BLOCK_SIZE; blockSize < totalSize; blockSize++){
				result += getPermutations(totalSize - blockSize - 1);
			}
			cache.put(totalSize, result);
		}
		
		return result;
	}
	
	public static void main(String[] argv){
		new Problem114().solve();
	}
}
