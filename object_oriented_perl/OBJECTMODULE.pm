#!/usr/bin/perl
package OBJECTMODULE;
use parent 'OBJECT';

use strict;
use warnings;

#return string of object
sub to_string{
    my ($self, @args) = @_;
    my @strings = ();
    foreach my $attr (@args)
    {
        push @strings, "$self->{$attr}";
    }
    return @strings;
}

sub set_attr{
    my ($self, $attr, $val) = @_;
    $self->{$attr} = $val;
    return $self->{$attr};
}

sub get_attr{
    my ($self, $attr) = @_;
    return $self->{$attr};
}



1;

