use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CatalystBlog';
use CatalystBlog::Controller::Posts;

ok( request('/posts')->is_success, 'Request should succeed' );
done_testing();
