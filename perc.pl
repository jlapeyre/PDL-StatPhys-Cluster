#!/usr/bin/perl

use PDL;
use PDL::Cluster;
use PDL::NiceSlice;

=pod

sub site_perc_sample {
    my ($lattice, $p,$iopts) = @_;
    $iopts = {} unless defined $iopts;
    my $opt = new PDL::Options({ open_site => 1});
    my $opts = $opt->options($iopts);
    my @dims = $lattice->dims;
    my $nums = random(@dims);
    if ( $opts->{open_site} == 1 ) {
        $lattice .=  ($nums < $p);
    }
    else {
        $lattice .=  ($opts->{open_site}) * ($nums < $p);
    }
}

=cut

sub site_perc_sample {
    my ($lattice, $p,$iopts) = @_;
    $iopts = {} unless defined $iopts;
    my $opt = new PDL::Options({ open_site => 1});
    my $opts = $opt->options($iopts);
    my @dims = $lattice->dims;
    my $nums = random(@dims);
    if ( $opts->{open_site} == 1 ) {
        $lattice .=  ($nums < $p);
    }
    else {
        $lattice .=  ($opts->{open_site}) * ($nums < $p);
    }
}
