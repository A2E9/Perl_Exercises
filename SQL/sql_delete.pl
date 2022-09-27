use DBI;
use utf8;
use strict;
use Switch;
use warnings;
use POSIX qw(strftime);

sub sql_MAIN_delete{
    my $db = shift;

    print "Enter person_id you want to delete: ";
    my $deleteID = <STDIN>;
    chomp $deleteID;
    deleteColumns($db, $deleteID);
}

sub deleteColumns {
    my $db = shift;
    my $persID = shift;
    my $firstPos = "DELETE";
    my $delete = $db->prepare("$firstPos FROM person WHERE person_id = $persID") or die "Error: ", $db->errstr;
    $delete->execute or die "Error: ", $db->errstr;
    print "Deleted person with person_id = $persID\n";
}

1;
