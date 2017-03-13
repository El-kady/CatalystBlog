use strict;
use warnings;

use CatalystBlog;

my $app = CatalystBlog->apply_default_middlewares(CatalystBlog->psgi_app);
$app;

