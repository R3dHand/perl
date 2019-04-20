#!usr/bin/bash
perl -e 'for(1 .. 100){if($_ % 3 == 0 && $_ % 5 == 0){print"fizzBuzz\n"}elsif($_ % 3 == 0){print "fizz\n"}elsif($_ % 5 == 0){print "buzz\n"}else{print "$_\n"}}'
