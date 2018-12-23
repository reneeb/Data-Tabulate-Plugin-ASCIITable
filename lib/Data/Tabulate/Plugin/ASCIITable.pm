package Data::Tabulate::Plugin::ASCIITable;

# ABSTRACT: generate ASCII tables with Data::Tabulate 

use warnings;
use strict;
use Text::Table::Tiny;

our $VERSION = '0.04';

=head1 SYNOPSIS


    use Data::Tabulate;
    
    my @array = (1..10);
    my $foo = Data::Tabulate->new();
    print $foo->render('ASCIITable',{data => [@array]});

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 METHODS

=head2 new

create a new object of C<Data::Tabulate::Plugin::ASCIITable>

=cut

sub new{
    return bless {}, shift;
}

=head2 output

returns a string that contains the ASCII table

=cut

sub output{
    my ($self,@data) = @_;

    my $table = Text::Table::Tiny::table( rows => \@data );

    # some minor changes to generate the same output as the 0.01 version
    # with Text::ASCIITable 0.17
    $table =~ s/\+([+-]+)\+\n/.$1.\n/;
    $table =~ s/\+([+-]+)\+\z/'$1'\n/ms;

    return $table;
}

1; # End of Data::Tabulate::Plugin::ASCIITable
