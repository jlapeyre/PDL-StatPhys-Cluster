#!/usr/bin/perl

use PDL;
use PDL::Cluster;
use PDL::NiceSlice;

$c = pdl float , [
    [ 
    [1,1,0,1,1],
    [1,1,0,0,0],
    [1,1,0,1,0],
    [0,0,0,0,0],
    [1,1,1,0,1],
    [1,1,1,0,1]
    ],
    [ 
    [1,1,1,1,1],
    [1,1,0,0,0],
    [1,1,0,1,0],
    [0,0,0,0,0],
    [1,1,1,0,1],
    [1,1,1,0,1]
    ]
];

#$p = SITE_PERC_2D_PC;
#$p = .1;


#($max_cluster_size, $cluster_size_distribution) = clustdist($c);

($maxc, $numc, $dist) = clustdist($c, { closed_site => 0} );

print "max cluster size: $maxc\n";
print "number of clusters: $numc\n";

# print cluster counts 
print $dist(0:$maxc->at(0)-1,(0)), "\n";
print $dist(0:$maxc->at(1)-1,(1)), "\n";
