requires 'perl', '5.008001';
requires 'XML::Parser';
requires 'XML::Simple';
requires 'HTTP::Request';
requires 'HTTP::Headers';
requires 'URI';
requires 'LWP::UserAgent';
requires 'Class::Accessor::Lite';
requires 'Digest::SHA';
requires 'Time::Piece';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

