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

my $POD_header = <<EOF;
=head1 OVERVIEW

A module for PDL providing cluster counting for 2-d,
site, statistical models.
This module is not on the CPAN.

=cut

EOF

if(exists $ARGV[0] && $ARGV[0] eq 'README.pod')
{
  open MOD, 'Cluster.pm' or die 'Could not open main module';
  open README, '>README.pod'              or die "Couldn't open README.pod";

  print README $POD_header;

  while (<MOD>)
  {
    if (/^=/../^=cut/)
    { print README; }
  }
}
