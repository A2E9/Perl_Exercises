use DBI;
use utf8;
use strict;
use Switch;
use warnings;
use POSIX qw(strftime);
package main;

require "./sql_insert.pl";
require "./sql_delete.pl";
require "./sql_cmd.pl";
require "./sql_print.pl";
 


main();
sub main
{
    my $dsn = "DBI:mysql:test:localhost";
    my $user = "root";
    my $password = "admin123\$";
    my $db = connect_db($dsn, $user, $password);

    print "1. Insert\n2. Delete\n3. SQL-Statement\n4. Print-Table\n5. Exit\nYOUR CHOICE: ";
    my $choice = <STDIN>;
    chomp $choice;
    switch($choice){
        case 1 {sql_MAIN_insert($db)}
        case 2 {sql_MAIN_delete($db)}
        case 3 {sql_MAIN_cmd($db)}
        case 4 {sql_MAIN_print($db)}
        case 5 {exit}
        default {print "Wrong input! Try again!\n"; main()}
    }
}


sub connect_db {
    my $dsn = shift;
    my $user = shift;
    my $password = shift;
    my $db = DBI->connect($dsn, $user, $password, { RaiseError => 1});
    return $db;
}









# my $fields = join(' ', @{$result->{NAME}});
# print "$fields\n";

# while (my $row = $result->fetchrow_arrayref) {
#     print join(',', @$row),"\n";
# }
# my $add = $db->prepare("Select person_id ,Anrede, Titel from person");
# $add->execute();

# my($i, $anrede, $titel);

# while(($i, $anrede, $titel) = $add->fetchrow())
# {
#   if($anrede eq "")
#   {
#     $anrede = "NULL";
#   } 
#   print("$i, $anrede, $titel\n");  
# }

#Nr.;Anrede;Titel;Vorname;Nachname;Geburtsdatum;Straße;Hausnummer;Postleitzahl;Stadt;Telefon;Mobil;Telefax;EMail;Newsletter;Eintragsdatum

# print "Anrede: ";
# my $anrede = <STDIN>;
# chomp $anrede;

# print "Titel: ";
# my $titel = <STDIN>;
# chomp $titel;

# print "Vorname: ";
# my $vorname = <STDIN>;
# chomp $vorname;

# print "Nachname: ";
# my $nachname = <STDIN>;
# chomp $nachname;

# print "Geburtsdatum: ";
# my $geburtsdatum = <STDIN>;
# chomp $geburtsdatum;

# print "Straße: ";
# my $strasse = <STDIN>;
# chomp $strasse;

# print "Hausnummer: ";
# my $hausnummer = <STDIN>;
# chomp $hausnummer;

# print "Postleitzahl: ";
# my $postleitzahl = <STDIN>;
# chomp $postleitzahl;

# print "Stadt: ";
# my $stadt = <STDIN>;
# chomp $stadt;

# print "Telefon: ";
# my $telefon = <STDIN>;
# chomp $telefon;

# print "Mobil: ";
# my $mobil = <STDIN>;
# chomp $mobil;

# print "Telefax: ";
# my $telefax = <STDIN>;
# chomp $telefax;

# print "EMail: ";
# my $email = <STDIN>;
# chomp $email;

# print "Newsletter: ";
# my $newsletter = <STDIN>;
# chomp $newsletter;

# print "Eintragsdatum: ";
# my $eintragsdatum = <STDIN>;
# chomp $eintragsdatum;

# if($anrede eq "")
# {
#   #$anrede = (NULL);
# }
# if($titel eq "")
# {
#   $titel = "vooo";
# }
# if($vorname eq "")
# {
#   $vorname = "NULL";
# }
# if($nachname eq "")
# {
#   $nachname = "NULL";
# }
# if($geburtsdatum eq "")
# {
#   $geburtsdatum = '0000-00-00';
# }
# if($strasse eq "")
# {
#   $strasse = "NULL";
# }
# if($hausnummer eq "")
# {
#   $hausnummer = "NULL";
# }
# if($postleitzahl eq "")
# {
#   $postleitzahl = 0;
# }
# if($stadt eq "")
# {
#   $stadt = "NULL";
# }
# if($telefon eq "")
# {
#   $telefon = "NULL";
# }
# if($mobil eq "")
# {
#   $mobil = "NULL";
# }
# if($telefax eq "")
# {
#   $telefax = "NULL";
# }
# if($email eq "")
# {
#   $email = "NULL";
# }
# if($newsletter eq "")
# {
#   $newsletter = "NULL";
# }
# if($eintragsdatum eq "")
# {
#   my $datestring = strftime "%Y-%m-%d", localtime;
#   $eintragsdatum = $datestring;
#   #print $eintragsdatum;
# }


# my $add = $dbh->prepare("INSERT INTO person (Anrede, Titel, Vorname, Nachname, Geburtsdatum, Strasse, Hausnummer, Postleitzahl,
# Stadt, Telefon, Mobil, Telefax, EMail, Newsletter, Eintragsdatum)
# VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");


# my $names = $add->{NAME};
# my $numFields = $add->{NUM_OF_FIELDS} - 1;

# $add->bind_param(1, $anrede);
# $add->bind_param(2, $titel);
# $add->bind_param(3, $vorname);
# $add->bind_param(4, $nachname);
# $add->bind_param(5, $geburtsdatum);
# $add->bind_param(6, $strasse);
# $add->bind_param(7, $hausnummer);
# $add->bind_param(8, $postleitzahl);
# $add->bind_param(9, $stadt);
# $add->bind_param(10, $telefon);
# $add->bind_param(11, $mobil);
# $add->bind_param(12, $telefax);
# $add->bind_param(13, $email);
# $add->bind_param(14, $newsletter);
# $add->bind_param(15, $eintragsdatum);
# $add->execute();
#my $sth = $dbh->prepare("SELECT * FROM person");
# $add->execute($anrede, $titel, $vorname, $nachname, $geburtsdatum, $strasse, $hausnummer, $postleitzahl, $stadt, $telefon, 
# $mobil, $telefax, $email, $newsletter, $eintragsdatum);




#print($names, " ", $numFields);

# print  join(", ", @$names);
# print  $numFields;

# do
# {
#   while (my @row = $sth->fetchrow_array())
#   {
#     foreach my $row (@row)
#     {
#         if (defined $row)
#         {
#             print "$row | ";
#         }
#         else
#         {
#             print "voll | ";
#         }
      
#     }
#     print "\n";
#   }
# } while ($sth->more_results)

