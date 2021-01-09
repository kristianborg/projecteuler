@numbers = (1..20);
$found = 0;
$result = 2;
while(!$found){
	$result+=2;
	$found = 1;
	foreach(@numbers){
		if ($result % $_ != 0){
			if ($_ > 17){
				print "$result does not divide $_\n";
			}
			$found = 0;
			last;
		}
	}
}
print "\nResult: $result";