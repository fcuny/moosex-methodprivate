#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 6;
use Test::Exception;

{

    package Foo;
    use Moose;
    use MooseX::MethodPrivate;

    private 'bar' => sub {
        my $self = shift;
        return 'baz';
    };

    sub baz {
        my $self = shift;
        return $self->bar;
    }

    sub foo {
        my $self = shift;
        return $self->foobar(shift);
    }

    private 'foobar' => sub {
        my $self = shift;
        my $str  = shift;
        return 'foobar' . $str;
    };

}

{

    package Bar;
    use Moose;
    extends 'Foo';

    sub newbar {
        my $self = shift;
        return $self->bar;
    }
}

my $foo = Foo->new();
isa_ok( $foo, 'Foo' );
dies_ok { $foo->bar } "... can't call bar, method is private";
is $foo->baz, 'baz', "... got the good value from &baz";
is $foo->foo('baz'), 'foobarbaz', "... got the good value from &foobar";

my $bar = Bar->new();
isa_ok( $bar, 'Bar' );
dies_ok { $bar->newbar() } "... can't call bar, method is private";
