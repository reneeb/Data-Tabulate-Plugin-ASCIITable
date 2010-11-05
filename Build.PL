use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Data::Tabulate::Plugin::ASCIITable',
    license             => 'perl',
    dist_author         => 'Renee Baecker <module@renee-baecker.de>',
    dist_version_from   => 'lib/Data/Tabulate/Plugin/ASCIITable.pm',
    build_requires => {
        'Test::More'          => 0,
        'Test::CheckManifest' => 1.0,
        'Text::ASCIITable'    => 0.17,
    },
    add_to_cleanup      => [ 'Data::Tabulate::Plugin::ASCIITable-*' ],
);

$builder->create_build_script();
