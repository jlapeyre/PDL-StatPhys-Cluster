use strict; use warnings;
use Test::More 0.96;
#use Test::More 0.96;

use PDL::LiteF;
use PDL::NiceSlice;
use PDL::StatPhys::Cluster;

ok(1, "PDL::StatPhys::Cluster loaded");

my $c = pdl long ,
    [ 
        [1,1,0,1,1],
        [1,1,0,0,0],
        [1,1,0,1,0],
        [0,0,0,0,0],        
        [1,1,1,0,1],
        [1,1,1,0,1]
     ];

my ($maxc, $numc, $dist) = clustdist($c);
$maxc = $maxc->at(0);

my $mmaxc = $maxc - 1;
#pinfo("maxc : $maxc\n");
#pinfo($dist);
#pinfo($dist("0:$mmaxc"));

ok( $maxc == 6);
ok( ($dist->slice("0:$mmaxc") == long [1, 2, 0, 0, 0, 2])->sum == 6);
#ok( $maxc == 6 );

done_testing;
