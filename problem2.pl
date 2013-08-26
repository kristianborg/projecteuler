use POSIX;
$max = 4000000;
$a = 1;
$b = 2;
@fib = ($a, $b);
while ($b < $max){
	$new = $a + $b;
	$a = $b;
	$b = $new;
	@fib[$#fib + 1] = $new;
}
print "fib: @fib\n";

$result = 0;
foreach(@fib){
	if (floor($_ / 2) == $_/2 && $_ < $max){
		print "adding $_\n";
		$result += $_;
	}
}
print "result: $result\n";