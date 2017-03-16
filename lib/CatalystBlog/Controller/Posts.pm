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

    if($c->user->manager == 0){
        $c->response->redirect($c->uri_for("/?no_access"));
        return;
    }

    $c->stash->{wrapper} = 'backend/wrapper.html';
    $c->stash(resultset => $c->model('DB::Post'));
}

sub list :Chained('base'):PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(posts => [$c->model('DB::Post')->all()]);
    $c->stash(template => 'backend/posts/list.html');
}

sub create :Chained('base'):PathPart('create') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(form_action => $c->uri_for($c->controller->action_for("do_create")));
    $c->stash(template => 'backend/posts/form.html');
}

sub do_create :Chained('base') :PathPart('do_create') :Args(0) {
    my ($self, $c) = @_;

    my $title = $c->request->params->{title} || "";
    my $content = $c->request->params->{content} || "";

    if ($title && $content) {
        my $post = $c->model('DB::Post')->create({
                title => $title,
                content => $content,
            });

        $c->response->redirect($c->uri_for("/posts/list"));
        return;
    } else {
        $c->flash->{error_msg} = "Empty title or content.";
    }

    $c->response->redirect($c->uri_for($self->action_for("create")));
}

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
    my ($self, $c,$id) = @_;
    $c->stash(object_id => $id);
    $c->stash(object => $c->stash->{resultset}->find($id));

}

sub edit :Chained('object') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;
    my $post = $c->stash->{object};

    $c->stash(form_action => $c->uri_for($c->controller->action_for("do_edit"),[$c->stash->{object_id}]));
    $c->stash(post => $post,template => 'backend/posts/form.html');
}

sub do_edit :Chained('object') :PathPart('do_edit') :Args(0) {
    my ($self, $c) = @_;

    my $title = $c->request->params->{title} || 'N/A';
    my $content = $c->request->params->{content} || 'N/A';

    my $post = $c->stash->{object}->update({
            title => $title,
            content => $content,
    });
    $c->response->redirect($c->uri_for($self->action_for("list")));
}

sub delete :Chained('object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{object}->delete;
    $c->response->redirect($c->uri_for($self->action_for("list")));
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
