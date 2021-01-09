use bigint;

$target = 100;
$fact = Math::BigInt->new($target)->bfac();
print "$target! = $fact\n";
$sum += $_ foreach(split("", $fact));
print "result: $sum\n";