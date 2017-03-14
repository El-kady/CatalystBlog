package CatalystBlog::Controller::Dashboard;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

CatalystBlog::Controller::Dashboard - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{wrapper} = 'backend/wrapper.html';

    my $admins_count = $c->model('DB::User')->search(
        {
            manager => 1
        }
    );

    my $members_count = $c->model('DB::User')->search(
        {
            manager => 0
        }
    );

    my $posts_count = $c->model('DB::User')->search();

    $c->stash(admins_count => $admins_count->count);
    $c->stash(members_count => $members_count->count);
    $c->stash(posts_count => $posts_count->count);

    $c->stash(template => 'backend/dashboard.html');
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
