package Data::Tabulate::Plugin::ASCIITable;

use warnings;
use strict;
use Text::ASCIITable;

=head1 NAME

Data::Tabulate::Plugin::ASCIITable - generate ASCII tables with C<Data::Tabulate>

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

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
    my $obj = Text::ASCIITable->new();
    my @headings = $self->_header_length(@data);
    $obj->setCols(@headings);
    for(@data){
        my @row = map{defined($_) ? $_ : ' '}@$_;
        $obj->addRow(@row);
    }
    
    my $table = ''.$obj;
    $table = join("\n",(split(/\n/,$table,4))[0,3]);
    return $table;
}

sub _header_length{
    my ($self,@data) = @_;
    
    my $cols = scalar(@{$data[0]});
    my %hash;
    @hash{(1..$cols)} = map{length $data[0]->[$_]}(0..$cols-1);
    for my $row(@data){
        for my $index(0..$cols-1){
            next unless defined $row->[$index];
            if(length $row->[$index] > $hash{$index+1}){
                $hash{$index+1} = length $row->[$index];
            }
        }
    }
    my @return = map{' ' x $hash{$_}}(1..$cols);
    return @return;
}

=head1 AUTHOR

Renee Baecker, C<< <module at renee-baecker.de> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-data-tabulate-plugin-asciitable at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Data::Tabulate::Plugin::ASCIITable>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Data::Tabulate::Plugin::ASCIITable

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Data::Tabulate::Plugin::ASCIITable>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Data::Tabulate::Plugin::ASCIITable>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Data::Tabulate::Plugin::ASCIITable>

=item * Search CPAN

L<http://search.cpan.org/dist/Data::Tabulate::Plugin::ASCIITable>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2006 Renee Baecker, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Data::Tabulate::Plugin::ASCIITable
