#!/usr/local/bin/perl
print "BookIt2 ============\n";

#BookIt2
# Read a file with keys to log items that need to be printed out from the first file
#

# all logs start with BEGIN
# all logs stop with END or ERROR
# the logs can be nested and overlapping
# find the "X ERROR" log statements and write "X" to a new file
#
# read the input file a second time
#   if X is in the first file and in second file write to a third file
my $start = time();
open my $errorLogFile, 'errorLog.txt' or die "could not open: errorLog.txt $!";
open my $keys, '<', 'errorKeys.txt' or die "cound not open: errorKeys $!";
open my $errorsText, '>', 'errorsText.txt' or die "could not open: errorsText.txt $!";

sub matchKey {
    my $key = "0";

    open my $keys, '<', 'errorKeys.txt' or die "cound not open: errorKeys $!";
    while ( defined( $key = <$keys> ))
    {    chomp $key;
        #print "Testing key = [$_[0]]\n";
        #print "read key = [$key]\n";

        if ( $_[0] eq $key )
        {
    #        print "matched key = $key\n";
            return 1;
        }
    }
    close $keys;
    0;
}
my $count = 0;
while ( defined( $line = <$errorLogFile> ))
{
    #print "$line";

    my @items = split / /, $line;
    #print "items[0] : $items[0]\n";
    my $match = &matchKey( $items[0] );
    #print "match : $match \n";
    if ( $match )
    {
        $count++;
        print $errorsText $line;
    }
}
#print while <$errorlogfile>;

close $errorlogfile;
close $keys;
close $errorsText;
my $duration = time() - $start;
print "Duration: $duration\n";
;
