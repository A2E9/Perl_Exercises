use DBI;
use utf8;
use strict;
use Switch;
use warnings;
use POSIX qw(strftime);

#data should apper under each column name

sub sql_MAIN_print{
    my $db = shift;

    printAll($db);
}

sub printAll {
    my $db = shift;

    my $sth = $db->prepare("SELECT * FROM person");
    $sth->execute or die "SQL Error: $DBI::errstr\n";


    my @names = (@{$sth->{NAME}}); 

    print  join(" | ",@names)."\n";


    #get biggest length of each column
    #if column is bigger than length of column name, use column length
    #else use column name length
    my @lengths = ();
    for (my $i = 0; $i < $sth->{NUM_OF_FIELDS}; $i++) {
        my $length = length($names[$i]);
        while (my $row = $sth->fetchrow_array) {
            if (length($row->[$i]) > $length) {
                $length = length($row->[$i]);
            }
        }
        push(@lengths, $length);
        $sth->execute or die "SQL Error: $DBI::errstr\n";
    }
   
    
    # do
    # {
    #     while (my @row = $sth->fetchrow_array())
    #     {
    #         foreach my $row (@row)
    #         {
    #             if (defined $row)
    #             {
    #                 print "$row | ";
    #             }
    #             else
    #             {
    #                 print "leer | ";
    #             }
            
    #         }
    #         print "\n";
    #     }
    # } while ($sth->more_results);

    

    foreach my $lll (@lengths)
    {
        print " ", $lll;
    }

}

1;




