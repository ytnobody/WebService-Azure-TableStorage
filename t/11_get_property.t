use strict;
use warnings;
use Test::More;
use WebService::Azure::TableStorage;

my $table_storage = WebService::Azure::TableStorage->new(account => 'ytnobody', key => 'foobar');
isa_ok $table_storage, 'WebService::Azure::TableStorage';

subtest get_property => sub {
    my $req = $table_storage->request->get_property;
    is $req->uri->path_query, '/?restype=service&comp=properties';
};

done_testing;
