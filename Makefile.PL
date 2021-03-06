use strict;
use warnings;
use ExtUtils::MakeMaker;

# Normalize version strings like 6.30_02 to 6.3002,
# so that we can do numerical comparisons on it.
my $eumm_version = $ExtUtils::MakeMaker::VERSION;
$eumm_version =~ s/_//;

WriteMakefile(
    NAME                => 'AuthMock',
    AUTHOR              => q{Marco Masetti grubert65@gmail.com},
    VERSION_FROM        => 'lib/AuthMock.pm',
    ABSTRACT            => 'A simple web mock app used to test network disruptions via ToxiProxy',
    ($eumm_version >= 6.3001
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'YAML'       => 0,
        'Dancer2'     => 0.207000,
        'Data::Printer' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'AuthMock-*' },
    test                => { RECURSIVE_TEST_FILES=>1 },
);
