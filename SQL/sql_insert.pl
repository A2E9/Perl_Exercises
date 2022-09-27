use DBI;
use utf8;
use strict;
use Switch;
use warnings;
use POSIX qw(strftime);



sub sql_MAIN_insert {
    my $db = shift;
    my $selectColumns = select_columns($db);
    my @columnNameArray = (@{$selectColumns->{NAME}});
    my @dataForSQL = check_input (@columnNameArray);

    sql_insert($db, @dataForSQL);
}

sub select_columns {
    my $db = shift;
    my $selectColumns = $db->prepare("SELECT Anrede, Titel, Vorname, Nachname, Geburtsdatum, Strasse, Hausnummer, Postleitzahl, Stadt, Telefon, Mobil, Telefax, EMail, 
    Newsletter FROM person") or die "Error: ", $db->errstr;
    $selectColumns->execute or die "Error: ", $db->errstr;
    return $selectColumns;
}

sub sql_insert {
    my $db = shift;
    my @dataForSQL = @_;

    @dataForSQL = @dataForSQL[1..$#dataForSQL];
    my $insert = $db->prepare("INSERT INTO person (Anrede, Titel, Vorname, Nachname, Geburtsdatum, Strasse, Hausnummer, Postleitzahl, Stadt, Telefon, Mobil, Telefax,
        EMail, Newsletter, Eintragsdatum) VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?,?)") or die "Error: ", $db->errstr;

    my $date = strftime "%Y-%m-%d", localtime; # Eintragsdatum
    $insert->execute(@dataForSQL,$date) or die "Error: ", $db->errstr;
}

sub check_input {
    my @columnNameArray = @_;

    my @dataForSQL = [];
    foreach my $columnName (@columnNameArray){

        my $line = ask_for_input($columnName);

        #redo if empty and not optional
        redo if ($line =~ /\A \s* \z/x && ($columnName eq "Anrede" || $columnName eq "Vorname" || $columnName eq "Nachname" || $columnName eq "Strasse" || 
        $columnName eq "Hausnummer" || $columnName eq "Postleitzahl" || $columnName eq "Stadt")); 

        push @dataForSQL, $line;
    }
    return @dataForSQL;
}

sub check_column {
    my $line = shift;
    my $columnName = shift;

    switch($columnName){
            case "Anrede"           {return anrede_func($columnName, $line)}
            case "Vorname"          {return letter_func($columnName, $line)}
            case "Nachname"         {return letter_func($columnName, $line)}
            case "Strasse"          {return letter_func($columnName, $line)}
            case "Stadt"            {return letter_func($columnName, $line)}
            case "Telefon"          {return number_func($columnName, $line)}
            case "Mobil"            {return number_func($columnName, $line)}
            case "Telefax"          {return number_func($columnName, $line)}
            case "Geburtsdatum"     {return date_func  ($columnName, $line)}
            case "Titel"            {return string_func($columnName, $line)}
            case "Hausnummer"       {return string_func($columnName, $line)}
            case "Postleitzahl"     {return plz_func   ($columnName, $line)}
            case "Newsletter"       {return newsle_func($columnName, $line)}
            case "EMail"            {return email_func ($columnName, $line)}
            default                 {print "Error: $columnName not found"; exit;}
        }
}

sub ask_for_input {
    my $columnName = shift;
    print "Enter $columnName: ";
    chomp( my $line = <STDIN> );
    my $temp = check_column($line, $columnName);
    return $temp;
}

sub error_func {
    my ($columnName) = @_;
    print "$columnName ist nicht im richtigen Format!\n";
    ask_for_input($columnName);
}

sub anrede_func {
    my ($columnName, $line) = @_;
    if (lc($line) eq "herr" || lc($line) eq "frau"){ $line = lc($line); return $line = ucfirst($line);}
    else {error_func($columnName);} 
}

sub newsle_func {
    my ($columnName, $line) = @_;
    if(lc($line) eq "ja" || lc($line) eq "nein"){ return $line = lc($line);}
    else {error_func($columnName);}
}

sub plz_func {
    my ($columnName, $line) = @_;
    if(length($line) eq 5 && $line =~ /^\d{5}/){return $line;}
    else {error_func($columnName);}
}

sub email_func {
    my ($columnName, $line) = @_;
    if($line =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i){return $line;}
    else {error_func($columnName);}
}

sub date_func {
    my ($columnName, $date) = @_;
    if ($date =~ /^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/){return $date;}
    else
    {
        print "Please enter $columnName in the format < YYYY-MM-DD >. \n";
        error_func($columnName);
    }
}

sub letter_func {
    my ($columnName, $letter) = @_;
    if ($letter =~ /^[a-zA-Z]+$/){return $letter;}
    else
    {
        print "Please enter $columnName in the format < A-Z >. \n";
        error_func($columnName);
    }
}

sub number_func {
    my ($columnName, $number) = @_;
    if ($number =~ /^[0-9]+$/){return $number;}
    else
    {
        print "Please enter $columnName in the format < 0-9 >. \n";
        error_func($columnName);
    }
}

sub string_func {
    my ($columnName, $string) = @_;
    if ($string =~ /^[a-zA-Z0-9]+$/){return $string;}
    else
    {
        print "Please enter $columnName in the format < A-Z, 0-9 >. \n";
        error_func($columnName);
    }
}

1;