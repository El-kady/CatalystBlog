package CatalystBlog::Controller::Users;
use Moose;
use namespace::autoclean;
use Digest::MD5 qw(md5_hex);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

CatalystBlog::Controller::Users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub base :Chained('/') :PathPart('users') :CaptureArgs(0) {
    my ($self, $c) = @_;

    if($c->user->manager == 0){
        $c->response->redirect($c->uri_for("/"));
        return;
    }

    $c->stash->{wrapper} = 'backend/wrapper.html';
    $c->stash(resultset => $c->model('DB::User'));
}

sub list :Chained('base'):PathPart('list') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(users => [$c->model('DB::User')->all()]);
    $c->stash(template => 'backend/users/list.html');
}

sub create :Chained('base'):PathPart('create') :Args(0) {
    my ($self, $c) = @_;
    $c->stash(form_action => $c->uri_for($c->controller->action_for("do_create")));
    $c->stash(template => 'backend/users/form.html');
}

sub do_create :Chained('base') :PathPart('do_create') :Args(0) {
    my ($self, $c) = @_;

    my $name = $c->request->params->{name} || "";
    my $email = $c->request->params->{email} || "";
    my $password = $c->request->params->{password} || "";
    my $manager = $c->request->params->{manager} || 0;

    if ($name && $email && $password) {
        my $regex = $email =~ /^[a-z0-9.]+\@[a-z0-9.-]+$/;
        if($regex){
            my $user_by_email = $c->model('DB::User')->search({email => $email});
            if ($user_by_email == 1) {
                $c->flash->{error_msg} = "You can't use this email, its already exists.";
            } else{
                my $user = $c->model('DB::User')->create({
                        name => $name,
                        email => $email,
                        password => md5_hex($password),
                        manager => $manager
                    });
                $c->response->redirect($c->uri_for($self->action_for("list")));
                return;
            }
        }else{
            $c->flash->{error_msg} = "Please enter valid email.";
        }
    } else {
        $c->flash->{error_msg} = "Empty name,email or password.";
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
    my $user = $c->stash->{object};

    $c->stash(form_action => $c->uri_for($c->controller->action_for("do_edit"),[$c->stash->{object_id}]));
    $c->stash(user => $user,template => 'backend/users/form.html');
}

sub do_edit :Chained('object') :PathPart('do_edit') :Args(0) {
    my ($self, $c) = @_;

    my $name = $c->request->params->{name} || "";
    my $email = $c->request->params->{email} || "";
    my $password = $c->request->params->{password} || "";
    my $manager = $c->request->params->{manager} || 0;

    if ($name && $email && $password) {
        my $regex = $email =~ /^[a-z0-9.]+\@[a-z0-9.-]+$/;
        if($regex){
            my $user = $c->stash->{object}->update({
                    name => $name,
                    email => $email,
                    password => md5_hex($password),
                    manager => $manager
                });
            $c->response->redirect($c->uri_for($self->action_for("list")));
            return;
        }else{
            $c->flash->{error_msg} = "Please enter valid email.";
        }
    } else {
        $c->flash->{error_msg} = "Empty name,email or password.";
    }

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
