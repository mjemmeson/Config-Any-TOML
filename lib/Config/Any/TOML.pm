use strict;
use warnings;
package Config::Any::TOML;

use base 'Config::Any::Base';

=head1 NAME

Config::Any::TOML - Load TOML config files

=head1 DESCRIPTION

Loads TOML files. Example:

#TODO

=head1 METHODS

=head2 extensions( )

return an array of valid extensions (C<ini>).

=cut

sub extensions {
    return qw( toml );
}

=head2 load( $file )

Attempts to load C<$file> as an TOML file.

=cut

sub load {
    my $class = shift;
    my $file  = shift;

    open( my $fh, $file ) or die $!;
    my $content = do { local $/; <$fh> };
    close $fh;

    require TOML;

    my ( $data, $err ) = TOML::from_toml($content);
        unless ($data) {
        die "Error parsing toml: $err";
    }

    return $data;
}

=head2 requires_one_of( )

Specifies that this module requires one of the following TOML modules in order
to work.

=over

=item *

L<TOML>

=back

=cut

sub requires_one_of { 'TOML' }

=head1 SEE ALSO

=over

=item * L<Config::Any>

=item * L<TOML>

=back

=cut

1;
