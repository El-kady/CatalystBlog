use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CatalystBlog';
use CatalystBlog::Controller::Dashboard;

ok( request('/dashboard')->is_success, 'Request should succeed' );
done_testing();
