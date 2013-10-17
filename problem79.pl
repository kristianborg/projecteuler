use strict;
my @inputs = (
319,
680,
180,
690,
129,
620,
762);   #antwoord = 18347

my $solution = 10000;
while(1){
	my $found = 1;
	for my $input (@inputs){
		my @digits = split("", $input);
		my $pointer = 0;
		for my $digit (@digits){
			$pointer = index ($solution, $digit, $pointer);
			if ($pointer == -1){
				print "$solution fails on $input\n";
				$found = 0;
				last;
			}
			$pointer++;
		}
		if (!$found){
			last;
		}
	}
	if ($found){
		print "result: $solution\n";
		last;
	}
	#exit
	$solution++;
}