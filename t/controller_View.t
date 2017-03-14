use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CatalystBlog';
use CatalystBlog::Controller::View;

ok( request('/view')->is_success, 'Request should succeed' );
done_testing();
