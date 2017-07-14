#!/usr/local/bin/perl
print "BookIt_gen ============\n";

#BookIt_Gen
# Generate errorLog.txt for Testing

# all logs start with BEGIN
# all logs stop with END or ERROR
# the logs can be nested and overlapping
# find the "X ERROR" log statements and write "X" to a new file
#
# read the input file a second time
#   if X is in the first file and in second file write to a third file

open my $errorLogFile, '>', 'errorLog.txt' or die "could not open: errorLog.txt $!";
open my $wordsFile, '<', 'google-10000-english.txt' or die "could not open: 'google-10000-english.txt' $!";

my @words;
while ( <$wordsFile> ) {
    chomp $_;
    push ( @words, $_ );
}
close $wordsFile;


sub randomErrorText {
    my $errorLine = "";
    my $range = 20;
    my $minimum = 3;
    my $random_number = int( rand( $range)) + $minimum;
    # we now have a random number between 3 and 23 which is the number of words in the error line
    my $word = 0;
    for (my $var = 0; $var < $random_number; $var++) {
        # grab random words from @words

        $word = int( rand( 9999 ));
        $errorLine .= $words[$word] . " ";
    }
    chomp $errorLine;
    #print "$errorLine\n";
    $errorLine;
}

my @endOrError = ( 'ERROR', 'END' );
sub generateErrors {
    my $index = shift; # index of the error to generate
    my $text;
    my @errorLines;
    my $errorLine;
    my $range = 13;
    my $minimum = 1;
    my $random_number = int( rand( $range)) + $minimum;
    # we now have a random number between 1 and 13 which is the number of error lines

    $text = "BEGIN";
    $errorLine = "$index $text\n";
    push @errorLines, $errorLine;

    for (my $var = 0; $var < $random_number; $var++) {
        $text = &randomErrorText( $index );
        $errorLine = "$index $text\n";
        push @errorLines, $errorLine;
    }
    my $chance = 100;
    my $flip = int( rand( $chance ));
    #print "flip = $flip";
    if ( $flip != 0 )
    {
        $flip = 1;
    }
    $text = $endOrError[$flip];
    $errorLine = "$index $text\n";
    push @errorLines, $errorLine;
    print $errorLogFile @errorLines;
    0;
}
my @log;

my $start = time();

for (my $var = 0; $var < 100000; $var++) {

    &generateErrors( $var );

}
my $stop = time();
my $duration = $stop - $start;
print "Duration: $duration \n";

close $errorlogfile;



1;
