$target = 1000;
for ($a = 1; $a <= $target; $a++){
	for ($b = $a; $b < $target - $a; $b++){
		$c = $target - $a - $b;
		if ($a ** 2 + $b ** 2 == $c ** 2){
			print "$a^2 + $b^2 = $c^2\n";
			print "product: ", $a * $b * $c, "\n";
		}
	}
}