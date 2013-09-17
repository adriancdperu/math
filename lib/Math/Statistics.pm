package Math::Statistics;

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


sub sort {
    my (@nums) = @_;
    my $number = $#nums + 1;
    my @sorted = sort { $a <=> $b } @nums;
    return @sorted;
}

sub total_sum {
    my ($number, @nums) = @_;

    my $counter = 0;
    my $total;

    while ($counter < $number)  {
        $total = $total + $nums[$counter];
        $counter++;
    }
    return $counter;
}

sub basic_metrics {
    my (@sorted_array) = @_;

    my $minimum = shift(@sorted_array);
    my $maximum = pop(@sorted_array);
    my $range = $maximum - $minimum;
    my $midrange = ($minimum + $maximum) / 2;
    $midrange = sprintf("%.1f", $midrange);

    my %count;

    my @unique = grep { ++$count{$_} < 2 } @sorted_array;
    my $unique_sum = $#unique + 1;

    return my $response_data = +{
        "min"           =>  $minimum,
        "max"           =>  $maximum,
        "range"         =>  $range,
        "mid range"     =>  $midrange,
        "unique sum"    =>  $unique_sum,
    };
}

1;
