#!/usr/bin/perl
package OBJECT;
use strict;
use warnings;


sub new{
    my ($class,%args) = @_;
    my $self = bless \%args, $class;
}

1;
