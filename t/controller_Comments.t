use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CatalystBlog';
use CatalystBlog::Controller::Comments;

ok( request('/comments')->is_success, 'Request should succeed' );
done_testing();
