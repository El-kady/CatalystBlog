package CatalystBlog::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    WRAPPER => 'wrapper.html'
);

=head1 NAME

CatalystBlog::View::HTML - TT View for CatalystBlog

=head1 DESCRIPTION

TT View for CatalystBlog.

=head1 SEE ALSO

L<CatalystBlog>

=head1 AUTHOR

Moustafa Elkady

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
