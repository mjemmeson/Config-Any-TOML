use strict;
use warnings;
package Config::Any::TOML;

# VERSION

# ABSTRACT: Load TOML config files

use base 'Config::Any::Base';

=head1 DESCRIPTION

Loads TOML files. See L<https://github.com/mojombo/toml>

=head1 METHODS

=head2 extensions()

return an array of valid extensions (C<toml>).

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

=head2 requires_any_of()

Specifies that this module requires one of the following TOML modules in order
to work.

=over

=item *

L<TOML>

=back

=cut

sub requires_any_of { 'TOML' }

=head1 SEE ALSO

=over

=item * L<Config::Any>

=item * L<TOML>

=back

=cut

1;
