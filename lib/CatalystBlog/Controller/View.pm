package CatalystBlog::Controller::View;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

CatalystBlog::Controller::View - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :CaptureArgs(1){
    my ( $self, $c,$id ) = @_;

    $c->response->body('Matched CatalystBlog::Controller::View in View.'.$id);
}



=encoding utf8

=head1 AUTHOR

Moustafa Elkady

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
