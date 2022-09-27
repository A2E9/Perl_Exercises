use DBI;
use utf8;
use strict;
use Switch;
use warnings;
use POSIX qw(strftime);


sub sql_MAIN_cmd{
    my $db = shift;

    print "Enter SQL statement: ";
    my $sqlStatement = <STDIN>;
    chomp $sqlStatement;
    deleteColumns($db, $sqlStatement);
}

sub deleteColumns {
    my $db = shift;
    my $statement = shift;
    my $run = $db->prepare("$statement") or die "Error: ", $db->errstr;
    $run->execute or die "Error: ", $db->errstr;
    print "Executed!\n";
}

1;
