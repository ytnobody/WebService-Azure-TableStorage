package WebService::Azure::TableStorage::Request;
use strict;
use warnings;
use parent 'HTTP::Request';

use Time::Piece;
use HTTP::Headers;
use Digest::SHA ();
use Digest::MD5 ();
use URI;

our $X_MS_VERSION = '2015-02-21';
our $ENDPOINT_URL_FORMAT = 'https://%s.table.core.windows.net';

sub new {
    my ($class, $table_storage) = @_;
    my $self = $class->SUPER::new(GET => '/',
        HTTP::Headers->new(
            'Date'         => localtime->strftime('%a, %d %b %Y %H:%M:%S %Z'),
            'x-ms-version' => $X_MS_VERSION,
        ),
    );
    $self->{table_storage} = $table_storage;
    $self;
}

sub table_storage {
    my $self = shift;
    $self->{table_storage};
}

sub _sign {
    my $self = shift;
    $self->header('Content-MD5' => Digest::MD5::md5_base64($self->content));
    my $string = join "\n", 
        $self->method,
        $self->header('Content-MD5'),
        $self->header('Content-Type'),
        $self->header('Date'),
        $self->uri->path_query
    ;
warn "\n***SIGN\n$string\n";
    Digest::SHA::sha256_base64($string);
}

sub _authorized_header {
    my $self = shift;
    sprintf('SharedKey %s:%s', $self->table_storage->account, $self->_sign);
}

sub _endpoint_url {
    my $self = shift;
    sprintf $ENDPOINT_URL_FORMAT, $self->table_storage->account;
}

sub build {
    my ($self, $method, $path, $param) = @_;
    $self->method($method);
    $self->uri(URI->new($self->_endpoint_url));
    $self->uri->path($path);
    $self->uri->query_form($param) if $param;
    $self->header(Authorization => $self->_authorized_header);
}

sub get_property {
    my $self = shift;
    $self->build(GET => '/', {restype => 'service', comp => 'properties'});
    $self;
}

1;
