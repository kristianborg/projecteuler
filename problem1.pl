use POSIX;
@numbers = (1..999);
$result = 0;
foreach(@numbers){
	if (floor($_ / 3) == $_/3 || floor($_ / 5) == $_/5){
		print "add $_\n";
		$result += $_;
	}
}
print "Result: " , $result;