package Math::Statistics;

use strict;
use warnings;
use utf8;

use Math::Base;
use Log::Minimal;
use Time::HiRes;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);
    $self->{request_start_time} = localtime;  # for use $c->request_start_time
    $self->{request_start_epoch} = [Time::HiRes::gettimeofday];
    $self;
}


sub sort {
    my ($class, @nums) = @_;
    
    my $number = $#nums + 1; #count how many
    my @sorted = sort { $a <=> $b } @Nums;	
    return @sorted;
}

1;
