#!/usr/bin/perl

use strict;
use warnings;

use OBJECTMODULE;
use TEST;

unless ($ARGV[0])
{
    message();
}

# For each option, call appropriate subroutine.
my %dispatchList = (
    "message"   => \&message,
    "run"       => \&run,
);

# Pass both as references
ProcessArgs (\@ARGV, \%dispatchList);

sub ProcessArgs {
    my ($argv, $dispatchList) = @_;

    foreach my $arg (@$argv)
    {
        if (exists $dispatchList->{$arg})
        {
            # The value must be a reference to a subroutine
            my $subReference = $dispatchList->{$arg};
            # Call it.
            &$subReference();
        }
        #option does not exist.
        else
        {
            if (exists $dispatchList->{"message"})
            {
                my $errorNo = 0;
                &{$dispatchList{"message"}($errorNo)};
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

    print "=============\n";
    print "enter command\n";
    print "=============\n";
    my $command = <STDIN>;
    chomp $command;

    while ($command ne "quit")
    {
        my @args = split(/ /, $command);
        my $sub = shift @args;
        print "sub -- $sub\n";

        if (exists $dispatchList{$sub})
        {
            eval { &{$dispatchList{$sub}}($object, @args) };
            warn $@ if $@;
        }

        print "=============\n";
        print "enter command\n";
        print "=============\n";
        $command = <STDIN>;
        chomp $command;
        print "command -- $command\n";
#        TEST::parsePCT($object);
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
    my @commandList = (
                       '==============================',
                       'POSSIBLE COMMANDS',
                       '==============================',
                       'set_attr <attribute> <value>',
                       'get_attr <attribute>',
                       'to_string <attribute>',
                       '=============================='
    );
    foreach (@commandList){print "$_\n";}
}
#help
sub test {
    my ($self, @args) = @_;
    $self->TEST:: . "$args[0]";
}
#user messages
sub message {
    my ($errorNo) = @_;
    unless ($errorNo)
    {
        print "from \'" . caller . "\' -- you need to enter the sub-routine to be run\n";
    }

}

1;

