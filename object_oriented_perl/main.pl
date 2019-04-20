#!/usr/bin/perl

#will add current working directory to @INC
BEGIN{unshift @INC, "."}

use strict;
use warnings;

use OBJECTMODULE;
use TEST;

# For each option, call appropriate subroutine.
my %dispatchList = (
    "run"       => \&run,
);

# Pass both as references
ProcessArgs (\@ARGV, \%dispatchList);

sub ProcessArgs {
    my ($argv, $dispatchList) = @_;

    unless (@ARGV) {message(0);}
    else{
        foreach my $arg (@$argv)
        {
            if (exists $dispatchList->{$arg})
            {
                # The value must be a reference to a subroutine
                my $subReference = $dispatchList->{$arg};
                # Call it.
                &$subReference();
            }
        }
    }
}

sub run {
    #create object to work with
    my $object = OBJECTMODULE->new();
    #List of subs that can be called
    my %dispatchList = (
                        "set_attr"  => \&set_attr,
                        "get_attr"  => \&get_attr,
                        "to_string" => \&to_string,
                        "test"      => \&test,
                        "message"   => \&message,
                        "help"      => \&help,
                       );

    my $command = <STDIN>;
    chomp $command;

    while ($command ne "quit")
    {
        my @args = split(/ /, $command);
        my $sub = shift @args;
        print "sub -- $sub\n";

        eval { &{$dispatchList{$sub}}($object, @args) };
        warn $@ if $@;


        $command = <STDIN>;
        chomp $command;
    }
}
#OBJECTMODULE METHODS

#set_attr(attr, val)
sub set_attr {
    my ($self, @args) = @_;
    $self->set_attr($args[0], $args[1]);
    print "SET -- $self->{$args[0]} \n";
}
#get_attr(attr)
sub get_attr {
    my ($self, @args) = @_;
    $self->get_attr($args[0]);
    print "GET -- $self->{$args[0]} \n";
}
#to_string(attr(s))
sub to_string {
    my ($self, @args) = @_;
    my @string = $self->to_string(@args);
    foreach(@string){print "TO STRING -- $_\n";}
}
#help
sub help {
    my ($self, @args) = @_;
    #user prompt
    my %commandList = (
                       '1' => 'set_attr <attribute> <value>',
                       '2' => 'get_attr <attribute>',
                       '3' => 'to_string <attribute>',
                       '4' => 'test <args>'
    );
    foreach my $key (sort keys %commandList){print "\'$key\' => \'$commandList{$key}\'\n";}
}

sub test {
    my ($self, @args) = @_;
    my $sub = shift @args;
    TEST->$sub(@args);
}
#user messages
sub message {
    my ($errorNo) = @_;
    my %errorLog = (
                    '0' => "from \'" . caller . "\' -- you need to enter the sub-routine to be run\n"
    );
    print "error : $errorLog{$errorNo}\n";
}

1;
