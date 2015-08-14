import java.util.HashMap;
import java.util.Map;

public class Problem115 {
	 
	private Map<String, Long> cache = new HashMap<String, Long>();
	private static final int MIN_BLOCK_SIZE = 50;
	private static final int TARGET_RESULT = 1000000;
	
	public void solve(){
		for (int unitLength = MIN_BLOCK_SIZE;;unitLength++){
			long result = getPermutations(unitLength, MIN_BLOCK_SIZE);
			if (result > TARGET_RESULT){
				System.out.println("unitLength " + unitLength + " is the first to exceed " + TARGET_RESULT + ": " + result);
				break;
			}
		}
	}
	
	private long getPermutations(int totalSize, int minBlockSize){
		long result = 0;
		String key = "" + totalSize + "|" + minBlockSize;
		if (totalSize == 0){
			result = 1;
		} else if (cache.containsKey(key)){
			return cache.get(key);
		} else {
			result += getPermutations(totalSize - 1, minBlockSize); // black block
			if (totalSize >= minBlockSize){
				result += 1; // completely filling remaining space
			}
			for (int blockSize = minBlockSize; blockSize < totalSize; blockSize++){
				result += getPermutations(totalSize - blockSize - 1, minBlockSize);
			}
			cache.put(key, result);
		}
		
		return result;
	}
	
	public static void main(String[] argv){
		new Problem115().solve();
	}
}
