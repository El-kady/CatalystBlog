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

sub index :Path :CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $post = $c->model('DB::Post')->find($id);

    $post->update({ hits => $post->hits + 1 });

    $c->stash(
        title => "dsfdsf",
        post => $post,
        template => 'frontend/view.html'
    );
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
