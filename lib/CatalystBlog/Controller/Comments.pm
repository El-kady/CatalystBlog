package CatalystBlog::Controller::Comments;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

CatalystBlog::Controller::Comments - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub create :Local :Args(0) {
    my ( $self, $c ) = @_;
    my $post_id = $c->request->params->{post_id} || "";

    my $name = $c->request->params->{name} || "";
    my $email = $c->request->params->{email} || "";
    my $comment = $c->request->params->{comment} || "";

    my $self_url = $c->request->params->{self_url} || "";

    if ($name && $email && $comment)
    {
        my $regex = $email =~ /^[a-z0-9.]+\@[a-z0-9.-]+$/;
        if ($regex)
        {
            my $comment = $c->model('DB::Comment')->create({
                    post_id => $post_id,
                    name => $name,
                    email => $email,
                    comment => $comment
                });
        }else{
            $c->flash->{error_msg} = "Please enter valid email.";
        }
    }else {
        $c->flash->{error_msg} = "Empty name,email or comment.";
    }

    $c->response->redirect($self_url);
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
