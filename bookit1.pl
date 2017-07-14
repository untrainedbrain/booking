#!/usr/local/bin/perl
print "BookIt1\n";


#BookIt
# read a log file of errors that span several lines
#


# all logs start with BEGIN
# all logs stop with END or ERROR
# the logs can be nested and overlapping
# find the "X ERROR" log statements and write "X" to a new file
#
# read the input file a second time
#   if X is in the first file and in second file write to a third file
my $start = time();

open my $keys, '>', 'errorKeys.txt' or die "cound not open: errorKeys $!";
open my $errorlogfile, 'errorLog.txt' or die "could not open: errorLog.txt $!";

my $title = <$errorlogfile>;
print "Report Title: $title";

my $count = 0;
while (defined( $line = <$errorlogfile> ))
{
    chomp $line;
    my @items = split / /, $line;
    if ( $items[1] eq "ERROR")
    {
        print $keys "$items[0]\n";
        #print $line;
        $count++;
    }
}
#print while <$errorlogfile>;

close $errorlogfile;
close $errorkeys;

my $duration = time() - $start;
print "Duration: $duration\n";

print "$count keys created\n";
;
