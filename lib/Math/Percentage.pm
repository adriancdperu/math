package Math::Percentage;

use strict;
use warnings;
use utf8;

use Math;
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

sub percentage {
    my (@nums, $total) = @_;
    my $number = scalar (@nums) + 1;
    my $counter = 0;
    my %new_numbers;

    while ($counter < $number){
        $new_numbers{$counter} = ($nums[$counter] / $total) * 100 + 0.5555;
        $new_numbers{$counter} = sprintf("%d", $new_numbers{$counter});
        $counter++;
    }

    return %new_numbers;
}

1;
