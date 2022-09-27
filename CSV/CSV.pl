use strict;
use utf8;

use open ':std', ':encoding(UTF-8)';
my $file = "testdaten.csv";
open (my $data, "<", $file) or die;

while(my $line = <$data>)
{
    chomp $line;

    my @words = split ";", $line;

    for(my $i = 0; $i <= @words.length(); $i++){
        
        if ($words[$i] eq ""){
            print " | leer";
        }else{
            print " | ",$words[$i];
        }
    }
    print " |\n";    
}


