use bigint;

$target = 1000;

$pow = 2 ** $target;
@digits = split('', $pow);
$sum = 0;
$sum+= $_ foreach(@digits);
print "2^$target=$pow\n";
print "Result: $sum\n";
