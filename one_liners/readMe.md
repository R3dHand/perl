Perl 'one liner' examples to be run in shell

fizzBuzz.sh
    -perl -e will run script passed inside the quotes
    the script inside the quotes in a more readable way
    for(1 .. 100){
        if ($_ % 3 == 0 && $_ % 5 == 0){
            print "fizzBuzz\n"
        }elsif($_ % 3 == 0){
            print "fizz\n"
        }elsif($_ % 5 == 0){
            print "buzz\n"
       }else{
            print "$_ \n"
        }
        }
    
