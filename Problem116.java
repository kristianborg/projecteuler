import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Problem116 {
	
	private List<Integer>blockSizes = Arrays.asList(2, 3, 4); 
	private Map<String, Long> cache = new HashMap<String, Long>();
	private static final int NUM_TILES = 50;
	
	public void solve(){
		long result = 0;
		for(int blockSize : blockSizes){
			long resultCurrentBlockSize = getPermutations(NUM_TILES, blockSize);
			resultCurrentBlockSize -= 1; // all tiles black is not allowed as solution
			result += resultCurrentBlockSize;
			System.out.println("blockSize " + blockSize + " has result " + resultCurrentBlockSize);
		}
		System.out.println("Result : " + result);
	}
	
	private long getPermutations(int totalSize, int blockSize){
		long result = 0;
		String key = "" + totalSize + "|" + blockSize;
		if (totalSize < blockSize){
			result = 1;
		} else if (totalSize == blockSize){
			result = 2;
		} else if (cache.containsKey(key)){
			return cache.get(key);
		} else {
			result += getPermutations(totalSize - blockSize, blockSize);
			result += getPermutations(totalSize - 1, blockSize);
			cache.put(key, result);
		}
		
		return result;
	}
	
	public static void main(String[] argv){
		new Problem116().solve();
	}

}
