use FileHandle;
use POSIX;

my $cipherTestString = readFile("problem59.txt");
my @cipherText = split(",", $cipherTestString);
my @keySpace = (65..90, 97..122); #all upper and lower case letters
my @alphabetSpace = (32, 44, 46, 65..90, 97..122); #space, comma, dot and all upper and lower case letters
my $keyLength = 3;
my $numKeys = (scalar @keySpace) ** $keyLength;

#@bla1 = (8, 8, 8, 8, 15, 15, 15, 15);
#@bla2 = (1, 2, 3);
#decrypt(\@bla1, \@bla2);
#exit;

my $maxPercentage = 0;
for(my $i = 0; $i < $numKeys; $i++){
	my @key = getKey($i);
	my @plainText = decrypt(\@cipherText, \@key);
	my $alfabetPercentage = getOverlapPercentage(\@plainText, \@alphabetSpace);
	if ($alfabetPercentage > $maxPercentage){
		$maxPercentage = $alfabetPercentage;
		print "key $i(@key): $alfabetPercentage%\n";
	}
}

sub getOverlapPercentage(){
	my $text = $_[0];
	my @text = @{$text};
	my $alphabet = $_[1];
	my @alphabet = @{$alphabet};
	my $numMatches = 0;
	foreach(@text){
		if ($_ ~~ @alphabet){
			$numMatches++;
		}
	}
	return $numMatches * 100 / (scalar @text);
}

sub decrypt(){
	my $cipherText = $_[0];
	my @cipherText = @{$cipherText};
	my $key= $_[1];
	my @key = @{$key};
	my $keyLength = scalar @key;
	my @result = ();
	for(my $i = 0; $i < @cipherText; $i++){
		my $keyDigit = @key[$i % $keyLength];
		my $decryptedDigit = $cipherText[$i] ^ $keyDigit;
		#print "decrypting $cipherText[$i] with $keyDigit results into $decryptedDigit\n";
		push(@result, $cipherText[$i] ^ $keyDigit);
	}
	
	#print "cipherText: @cipherText\n";
	#print "key: @key\n";
	#print "plaintext: @result\n";
	return @result;
}

sub getKey(){
	my $keyNum = $_[0];
	my $keyDigits = scalar @keySpace;
	my @key = ();
	for(my $i = $keyLength - 1; $i >= 0; $i--){
		$pointer = floor($keyNum / $keyDigits ** $i);
		push (@key, $keySpace[$pointer]);
		$keyNum -= $pointer * $keyDigits ** $i;
	}
	
	return @key;
}

sub readFile(){
	my $fh = FileHandle->new;
	if (!$fh->open("< $_[0]")) {
		print "failed to open file\n";
		exit;
	}
	my $result = <$fh>; 
	$fh->close;	
	return $result;
}