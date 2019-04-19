#!/usr/bin/perl
package OBJECT;
use strict;
use warnings;

sub new {
    my ($self, %args) = @_;
    my $self = bless \%args, $class
}

1;

