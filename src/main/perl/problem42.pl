use FileHandle;

my $file = "problem42.txt";
my $fh = FileHandle->new;
if (!$fh->open("< $file")) {
	print "failed to open file\n";
	exit;
}
my $wordString = <$fh>; 
$fh->close;

$wordString =~ s/"//g;
my @words = split(",", $wordString);
print "read ", scalar @words, " words\n";

my $maxWordLength = getMaxLength(\@words);
print "maxWordLength: $maxWordLength\n";

my $maxTriangleNum = $maxWordLength * 26;
@triangleNums = getTriangleNums($maxTriangleNum);
print "number of triangle numbers untill $maxWordLength * 26 = $maxTriangleNum: ", scalar @triangleNums, "\n";

my $result = 0;
foreach(@words){
	$sum = 0;
	$sum += ord()-64 foreach(split("", $_));
	if ($sum ~~ @triangleNums){
		print "triangular: $_ = $sum\n";
		$result++;
	}
}
print "result: $result\n";

sub  getTriangleNums(){
	my $max = $_[0];
	my @result = ();
	for(my $i = 1;;$i++){
		$triangleNum = 0.5 * $i * ($i + 1);
		if ($triangleNum > $max){
			last;
		}
		push(@result, $triangleNum);
	}
	return @result;
}

sub getMaxLength(){
	$maxLength = 0;
	foreach(@{$_[0]}){
		if (length $_ > $maxLength){
			$maxLength = length $_;
		}
	}
	return $maxLength;
}