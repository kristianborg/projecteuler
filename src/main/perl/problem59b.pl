use FileHandle;
use POSIX;

my $cipherTestString = readFile("problem59.txt");
my @cipherText = split(",", $cipherTestString);
my @keySpace = (65..90, 97..122); #all upper and lower case letters
my @alphabetSpace = (32, 44, 46, 48..57, 65..90, 97..122); #space, comma, dot, all digits and all upper and lower case letters
my $keyLength = 3;
my @key = (65..65 + $keyLength - 1);
print "Guessing key...\n";
for($i = 0; $i < $keyLength; $i++){
	my @tempKey = @key;
	my $maxPercentage = 0;
	foreach(@keySpace){
		@tempKey[$i] = $_;
		my @plainText = decrypt(\@cipherText, \@tempKey);
		my $alfabetPercentage = getOverlapPercentage(\@plainText, \@alphabetSpace);
		if ($alfabetPercentage > $maxPercentage){
			$maxPercentage = $alfabetPercentage;
			@key = @tempKey;
			print "key: ", toAscii(\@key), " results in a $alfabetPercentage% match\n";
		}
	}
}
print "Found key: ", toAscii(\@key), "\n";

my @plainText = decrypt(\@cipherText, \@key);
my $plainText = toAscii(\@plainText);
print "plainText: $plainText\n";

$sum = 0;
$sum += $_ foreach(@plainText);
print "result: $sum\n";

sub toAscii(){
	$digits = $_[0];
	@digits = @{$digits};
	$result = "";
	$result .= chr foreach(@digits);
	return $result;
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
		push(@result, $cipherText[$i] ^ $keyDigit);
	}
	return @result;
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