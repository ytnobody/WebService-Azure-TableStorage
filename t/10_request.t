use strict;
use warnings;
use Test::More;
use WebService::Azure::TableStorage;

my $table_storage = WebService::Azure::TableStorage->new(account => 'ytnobody', key => 'foobar');
isa_ok $table_storage, 'WebService::Azure::TableStorage';

subtest request => sub {
    my $req = $table_storage->request;
    isa_ok $req, 'HTTP::Request';
    isa_ok $req, 'WebService::Azure::TableStorage::Request';
    $req->uri->path('/oreore');
    $req->uri->query_form(foo => '123', bar => 'abc');
    is $req->uri->path_query, '/oreore?foo=123&bar=abc';
};

done_testing;
