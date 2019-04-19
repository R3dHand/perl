#!/usr/bin/perl
package TEST;

use parent 'OBJECTMODULE';

use strict;
use warnings;

sub hi {
    my (@args) = @_;
    foreach (@args){print "$_\n"}
}
1;
