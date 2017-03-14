package CatalystBlog::Controller::Login;
use Moose;
use namespace::autoclean;
use Digest::MD5 qw(md5_hex);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

CatalystBlog::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('login') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->stash(resultset => $c->model('DB::User'));
}

sub index :Chained('base') :PathPart("") :Args(0) {
    my ($self, $c) = @_;
    $c->stash(template => "frontend/login.html");
}

sub submit :Chained('base') :PathPart("submit") :Args(0) {
    my ($self, $c) = @_;

    my $email = $c->request->params->{email};
    my $password = $c->request->params->{password};

    if ($email && $password) {
        if ($c->authenticate({ email => $email,password => md5_hex($password)  } )) {
            $c->response->redirect($c->uri_for("/"));
            return;
        } else {
            $c->flash->{error_msg} = "Wrong username or password.";
        }
    } else {
        $c->flash->{error_msg} = "Empty email or password.";
    }
    $c->response->redirect($c->uri_for($c->controller('login')->action_for("")));
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
