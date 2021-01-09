use Date::Calc qw(:all);

$year = 1901;
$month = 1;
$day = 1;
$endYear = 2001;
$result = 0;
while(1){
	
	@date = ($year, $month, $day) = Add_Delta_Days($year, $month, $day, 1);
	if (@date[0] == $endYear){
		last;
	}
	
	if (Day_of_Week(@date) == 7){
		print "@date ", Day_of_Week(@date), "  ", @date[2];
		if (@date[2] == 1){
			print " -- FIRST --";
			$result++;
		}
		print "\n";
	}
}
print "sum sundays on first of month: $result\n";
