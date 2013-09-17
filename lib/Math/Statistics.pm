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


sub _sort {
    my (@nums) = @_;
    my @sorted = sort { $a <=> $b } @nums;
    return @sorted;
}

sub _number {
    my (@nums) = @_;
    my $number = $#nums + 1;
    return $number;
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
        "mid_range"     =>  $midrange,
        "unique_sum"    =>  $unique_sum,
    };
}

sub basic_stats {
    my (@nums) = @_;
    my $number = _number(@nums);
    my @sorted_array = _sort(@nums);
    my $basic_metrics = basic_metrics(@sorted_array);
    my $response_data;

    if ($number <=1){
        $response_data = +{
            "percent_unique" => "100%",
            "median"         => $nums[0],
            "midrange"       => $nums[0],
            "rounded_mean"   => $nums[0],
            "standard_dev"   => 0,
        }
        ;
    } else {

        my $percent_unique = ( $response_data->{unique_sum} / $number )
                             * 100 + 0.5555; #TODO: Move to Constants
        $percent_unique = sprintf("%d%%", $percent_unique);

        my $mean = $total / $number;
        my $number2 = $number -1;
        my $counter = 0;
        my $sum_of_squares;

        while ($counter < $number){
            $sum_of_squares = $sum_of_squares +
                              ($nums[$counter] - $mean)**2;
            $counter++
        }

        my $standard_deviation = sqrt ($sum_of_squares / $number2);
        my $sd = sprintf("%.1f", $standard_deviation);

        my $mean_rounded = sprintf("%.1f", $mean);

        my $mid_point = $number / 2;
        my $midi = sprintf("%d", $mid); #round
        my $midi2 = $midi - 1;

        my $even1 = splice(@sorted, $midi, 1);
        my $even2 = splice(@sorted, $midi2, 1);

        my $median2 = ($even1 + $even2) / 2;
        my $median;

        if ($mid_point > $midi) {
            $median = sprintf("%.1f", $even1);
        } else {
            $median = sprintf("%.1f", $median2);
        }

        $response_data = +{
            "percent_unique" => $percent_unique,
            "median"         => $median,
            "midrange"       => $mid_point,
            "rounded_mean"   => $mean_rounded,
            "standard_dev"   => $sd,
        }
        ;
    }
    return $response_data;
}


1;
