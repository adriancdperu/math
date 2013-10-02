package Math::Time;

use strict;
use warnings;
use utf8;

use Math;
use Log::Minimal;
use Time::HiRes;

our $VERSION = '0.01';

sub day {
    my $self  = shift;
    my $year  = $self->{r}->param('year');
    my $month = $self->{r}->param('month');
    my $day   = $self->{r}->param('day');
    
    my @today = today();
    $year  ||= $today[0];
    $month ||= $today[1];
    $day   ||= $today[2];
    
    return ( $year, $month, $day );
}


sub day_hour {
    my $self = shift;
    my ( $year, $month, $day ) = $self->day;
    my $hour = $self->{r}->param('hour');
    $hour = ( now() )[0] if not defined $hour;
    
    return ( $year, $month, $day, $hour );
}

sub today {

}

sub now {

}

1;
