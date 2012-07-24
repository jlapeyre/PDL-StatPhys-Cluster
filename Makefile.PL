  # Makefile.PL for a package defined by PP code.

use PDL::Core::Dev;
use ExtUtils::MakeMaker;

$package = ["cluster.pd",Cluster,PDL::StatPhys::Cluster];
%hash = pdlpp_stdargs($package);
$hash{'VERSION_FROM'} = 'cluster.pd';
$hash{'ABSTRACT_FROM'} = 'cluster.pd';
$hash{OBJECT} .= ' ';
$hash{DEFINE} .= ' ';
$hash{AUTHOR}  = q{John Lapeyre <jlapeyre@cpan.org>};
$hash{LICENSE} = 'perl';
$hash{PREREQ_PM} = {
        'Test::More' => 0,
        'PDL' => 0
};
WriteMakefile(%hash);

sub MY::postamble { pdlpp_postamble($package); }

