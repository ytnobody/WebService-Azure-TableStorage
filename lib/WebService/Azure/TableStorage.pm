package WebService::Azure::TableStorage;
use 5.008001;
use strict;
use warnings;
use LWP::UserAgent;
use Time::Piece;
use Carp ();
use XML::Simple;
use Class::Accessor::Lite (
    ro => [qw/account access_key/],
    new => 1,
);
use WebService::Azure::TableStorage::Request;

our $VERSION = "0.01";
our $TIMEOUT = 60;

$XML::Simple::PREFFERED_PARSER = 'XML::Parser';

sub request {
    my $self = shift;
    WebService::Azure::TableStorage::Request->new($self);
}

sub agent {
    my $self = shift;
    $self->{agent} = LWP::UserAgent->new(agent => __PACKAGE__.'/'.$VERSION, timeout => $TIMEOUT) if !$self->{agent};
    $self->{agent};
}

sub send_request {
    my ($self, $req) = @_;
    my $res = $self->agent->request($req);
    if (!$res->is_success) {
warn "\n***REQ\n".$req->as_string."\n";
        Carp::carp(sprintf('%s', $res->status_line));
        return undef;
    }
    XML::Simple::XMLin($res->content);
}

1;
__END__

=encoding utf-8

=head1 NAME

WebService::Azure::TableStorage - It's new $module

=head1 SYNOPSIS

    use WebService::Azure::TableStorage;

=head1 DESCRIPTION

WebService::Azure::TableStorage is ...

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

