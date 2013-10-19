use List::MoreUtils qw/ uniq /;
use strict;

my @keys = (319,680,180,690,129,620,762,689,762,318,368,710,720,710,629,168,160,689,716,731,736,729,316,729,729,710,769,290,719,680,318,389,162,289,162,718,729,319,790,680,890,362,319,760,316,729,380,319,728,716);
@keys = uniq(@keys);
print "keys: @keys\n";

my $keyLength = length(@keys[0]);
while(1){
	my @result = findPasscodes($keyLength);
	if (@result){
		print "Key length $keyLength: Found passcodes: @result\n";
		last;
	} else {
		print "Key length $keyLength: no result found\n";
	}
	$keyLength++;
}

sub findPasscodes(){
	my $maxKeyLength = $_[0];
	my @passcodes = (@keys[0]);
	for (my $i = 1; $i <= @keys; $i++){
		my $key = $keys[$i];
		my @keyDigits = split("", $key);
		for(my $i = 0; $i < @keyDigits; $i++){
			if ($i == 0){
				@passcodes = expandPasscodes(\@passcodes, $maxKeyLength, $keyDigits[$i]);
			} else {
				@passcodes = expandPasscodes(\@passcodes, $maxKeyLength, $keyDigits[$i], $keyDigits[$i - 1]);
			}
		}
		
		if (!@passcodes){
			return;
		}
	}
	return @passcodes;
}

sub expandPasscodes(){
	my $passcodes = $_[0];
	my @passcodes = @{$passcodes};
	my $maxKeyLength = $_[1];
	my $digit = $_[2];
	my $indexDigit = $_[3];
	
	my @result = ();
	for my $passcode (@passcodes){
	
		# calculate from which point in the passcode the digit should be added
		my $index = index($passcode, $indexDigit);
		if (!$indexDigit || $index == -1){
			# not found so add from the beginning
			$index = 0;
		} else {
			# we start at the position right after the index digit
			$index++;
		}
		
		if (length($passcode) != $maxKeyLength){
			# create passcode with new digit in every position starting from $index
			for(my $i = $index; $i < length ($passcode) + 1; $i++){
				my $newPasscode = substr($passcode, 0, $i) . $digit . substr($passcode, $i);
				push(@result, $newPasscode);
			}
		}
		
		# check if the original passcode satisfies as well
		if(index($passcode, $digit, $index) != -1){
			push(@result, $passcode);
		}
	}

	return uniq(@result);;
}