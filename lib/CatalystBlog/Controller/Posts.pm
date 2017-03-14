package CatalystBlog::Controller::Posts;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

CatalystBlog::Controller::Posts - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('posts') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash->{wrapper} = 'backend/wrapper.html';
}

sub list :Chained('base'):PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(posts => [$c->model('DB::Post')->all()]);
    $c->stash(template => 'backend/posts/list.html');
}

sub create :Chained('base'):PathPart('create') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(template => 'backend/posts/form.html');
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
