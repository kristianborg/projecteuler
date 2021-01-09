use strict;
use POSIX;
use Data::Dumper;
use bigint;

#my $function = "n ** 3";
#my $maxExponential = 3;
my $function = "1 - n + n ** 2 - n ** 3 + n ** 4 - n ** 5 + n ** 6 - n ** 7 + n ** 8 - n ** 9 + n ** 10";
my $maxExponential = 10;

print "solving problem 101 for function $function\n";

my @bops = (); 
my $bopSum = 0;
for(my $i = 1; $i <= $maxExponential; $i++){
	my @terms = getTerms($i);
	print "first $i terms: @terms\n";
	my @lineairEquations = getLineairEquationsForTerms(@terms);
	my @polynomials = solveLinearEquations(\@lineairEquations);
	my @incorrectTerms = getPolynomialResults(\@polynomials, $i + 1);
	print "matching polynomial " . generatePolinomialString(@polynomials) . " has terms @incorrectTerms\n";
	push(@bops,$incorrectTerms[-1]);
	$bopSum += $incorrectTerms[-1];
}
print "bops: @bops\n";
print "bop sum: $bopSum\n";

sub getPolynomialResults (){
	my @polynomial = @{$_[0]};
	my $numTerms = scalar @polynomial;
	my $numResults = $_[1];
	my @result = ();
	for (my $i = 1; $i <= $numResults; $i++){
		my $value = 0;
		for(my $j = 0; $j < $numTerms; $j++){
			my $pow = $numTerms - $j - 1;
			$value += $polynomial[$j] * $i ** $pow;
		}
		push(@result, $value);
	}
	
	return @result;
}
 
sub getTerms(){
	my $numTerms = $_[0];
	my @result = ();
	for (my $i = 1; $i <= $numTerms; $i++){
		my $populationFunction = $function;
		$populationFunction =~ s/n/$i/g;
		my $value = eval($populationFunction);
		push(@result, $value);
	}
 
	#print "first $numTerms terms of $function: @result\n";
	return @result;
}
 
sub getLineairEquationsForTerms(){
	my @equationResults = @_;
	my $numEquations = scalar @equationResults;
	my @equations = ();
	for (my $i = 1; $i <= $numEquations; $i++){
		my @equation = ();
		for (my $j = $numEquations - 1; $j >= 0; $j--){
			push(@equation, $i ** $j);
		}
		push(@equation, @equationResults[$i - 1]);
		push(@equations, \@equation);
	}
	return @equations;
}
 
sub solveLinearEquations(){
	my @equations = @{$_[0]};
	my $numEquations = scalar @equations;
	#print "processing $numEquations equations:\n";
	for my $equationPtr (@equations){
		my @equation = @{$equationPtr};
		if (scalar @equation != $numEquations + 1){
			print "invalid input for $numEquations equations: @equation\n";
			exit;
		}
		my $equationString = generateEquationString(@equation);
		#print "$equationString\n";
	}
 
	my @subResult = ();
	my @currentResult = ();
	if ($numEquations == 1){
		my @equation = @{$equations[0]};
		@currentResult = ($equation[1] / $equation[0]);
	} else {
		my @combinedEquations = combineAllEquations(\@equations);
		@subResult = solveLinearEquations(\@combinedEquations);
		@currentResult = (solveEquation($equations[0], \@subResult));
	}
	#print "result: $currentResult[0]\n";
	push(@currentResult, @subResult);
	return @currentResult;
}
 
 
sub solveEquation(){
	my @equation = @{@_[0]};
	my @substitutions = @{@_[1]};
	my $result = $equation[scalar @equation - 1];
	for (my $i = 0; $i < scalar @substitutions; $i++){
		$result -= $substitutions[$i] * $equation[$i + 1];
	}
	my $multiplier = $equation[0];
	$result /= $multiplier;
	#print "solving equation " . generateEquationString(@equation) . " with substitution @substitutions: $result\n";
	return $result;
}
 
sub combineAllEquations(){
	my @equations = @{$_[0]};
	my @result = ();
	for (my $i = 0; $i < scalar @equations - 1; $i++){
		my @equation1 = @{$equations[$i]};
		my @equation2 = @{$equations[$i + 1]};
		my @combinedEquation = combineEquations(\@equation1, \@equation2);
		push(@result, \@combinedEquation);
	}
	return @result;
}
 
sub combineEquations(){
	my @equation1 = @{$_[0]};
	my @equation2 = @{$_[1]};
	my $multiplier1 = $equation2[0];
	my $multiplier2 = $equation1[0];
	my @result = ();
	for (my $j = 1; $j < scalar @equation1; $j++){
		push(@result, $multiplier1 * $equation1[$j] - $multiplier2 * $equation2[$j]);
	}
	#print "combined " . generateEquationString(@equation1) . " and " . generateEquationString(@equation2) . " into " . generateEquationString(@result) . "\n";
	return @result;
}

sub generateEquationString(){
	my $result = "";
	for (my $i = 0; $i < scalar @_; $i++){
		if ($i == scalar @_ - 1){
			$result .= " = ";
		} elsif ($i != 0){
			$result .= " + ";
		}
 
		$result .= $_[$i];
 
		if ($i != scalar @_ - 1){
			$result .= chr(scalar @_ - $i - 2 + 97)
		}
	}
	#print "$result\n";
	return $result;
}

sub generatePolinomialString(){
	my @equation = @_;
	my $numTerms = scalar @equation;
	my $termNum = $_[1];
	my $result = "";
	for(my $i = 0; $i < $numTerms; $i++){
		my $pow = $numTerms - $i - 1;
		if ($i != 0){
			$result .= "+ ";
		}
		$result .= $equation[$i];
		if ($pow >= 2){
			$result .="*x^$pow"
		} elsif ($pow == 1){
			$result .="*x"
		}
		
		if ($i != $numTerms - 1){
			$result .= " ";
		}
	}
	
	#print "polynomial string of @equation: $result\n";
	return $result;
}