package AuthMock;
use Dancer2;
use RestAPI;
use CacheMock;

our $VERSION = '0.1';

# defaults for testing...
set cache_params => {
  http_verb => 'GET',
  scheme    => 'http',
  server    => 'localhost',
  port      => 8080,
  path      => 'login'
};

get '/login/:name' => sub {
    my $name = params->{name};

    my $cache = RestAPI->new(
        config->{cache_params}
    ) or die "Error getting a RestAPI object: $!";

    if ( $ENV{TEST_ACTIVE} ) {
        $cache->ua( CacheMock::get_test_ua() );
    }

    $cache->path( "$cache->{path}/$name" );
    my $user = $cache->do();
    return $user;
};

true;
