use strict;
use warnings;

use AuthMock;
use Test::More tests => 2;
use Plack::Test;
use HTTP::Request::Common;
use Ref::Util qw<is_coderef>;


my $app = AuthMock->to_app;
ok( is_coderef($app), 'Got app' );

my $test = Plack::Test->create($app);
my $res  = $test->request( GET '/login/wsmith' );
ok( $res->is_success, '[GET /login] successful' );

