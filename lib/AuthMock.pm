package AuthMock;
use Dancer2;
use RestAPI;
use CacheMock;
use Data::Printer;

our $VERSION = '0.1';

get '/login/:name' => sub {
    my $name = params->{name};

    debug("Cache params");
    debug( np config->{cache_params} );

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
