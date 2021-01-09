use feature "switch";
use POSIX;

$begin = 1;
$target = 1000;

$result = "";
for($i = $begin; $i <= $target; $i++){
	$numInWords = getNumberInWords($i);
	$numInWordsStripped = $numInWords;
	$numInWordsStripped =~ s/\s//g;
	print "$i: $numInWords - $numInWordsStripped\n";
	$result.=$numInWordsStripped;
}
print "total length $begin - $target: ", length($result), "\n";

sub getNumberInWords(){
	my $number = $_[0];
	if ($i == 1000){
		return "one thousand";
	}

	my $result = "";
	my $hundreds = floor($number / 100);
	if ($hundreds >= 1){
		$result.= toWords($hundreds) . " hundred";
		$number = $number - (100 * $hundreds);
		
		if ($number == 0){
			return $result;
		} else {
			$result.= " and";
		}
	}
	
	if ($number < 20){
		$result.= " " . toWords($number);
		return $result;
	}
		
	my $tens = floor($number / 10);
	if ($tens >= 1){
		$result.= " " . toWordsTens($tens);
	}
	
	$number = $number - (10 * $tens);
	if ($number >= 1){
		$result.= " " . toWords($number);
	}
	return $result;
}

sub toWordsTens(){
	my $number = $_[0];
	for ($number) {
		when (2)	{ return "twenty" }
		when (3)	{ return "thirty" }
		when (4)	{ return "forty" }
		when (5)	{ return "fifty" }
		when (6)	{ return "sixty" }
		when (7)	{ return "seventy" }
		when (8)	{ return "eighty" }
		when (9)	{ return "ninety" }
	}
	print "kut\n";
}

sub toWords(){
	my $number = $_[0];
	for ($number) {
		when (1)	{ return "one" }
		when (2)	{ return "two" }
		when (3)	{ return "three" }
		when (4)	{ return "four" }
		when (5)	{ return "five" }
		when (6)	{ return "six" }
		when (7)	{ return "seven" }
		when (8)	{ return "eight" }
		when (9)	{ return "nine" }
		when (10)	{ return "ten" }
		when (11)	{ return "eleven" }
		when (12)	{ return "twelve" }
		when (13)	{ return "thirteen" }
		when (14)	{ return "fourteen" }
		when (15)	{ return "fifteen" }
		when (16)	{ return "sixteen" }
		when (17)	{ return "seventeen" }
		when (18)	{ return "eighteen" }
		when (19)	{ return "nineteen" }
	}
	print "kut\n";
}