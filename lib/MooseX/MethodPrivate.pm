package MooseX::MethodPrivate;

use Moose;
use Moose::Exporter;
our $VERSION = '0.1.0';
use Carp qw/croak/;

Moose::Exporter->setup_import_methods(
    with_caller => [qw( private protected )], );

sub private {
    my $caller    = shift;
    my $name      = shift;
    my $real_body = shift;

    my $body = sub {
        croak "The $caller\::$name method is private"
            unless ( scalar caller() ) eq $caller;

        goto &{$real_body};
    };

    $caller->meta->add_method( $name, $body );
}

sub protected {
    my $caller    = shift;
    my $name      = shift;
    my $real_body = shift;

    my $body = sub {
        my $new_caller = caller();
        my @isa        = $new_caller->meta->superclasses;
        my @check      = grep {/$caller/} @isa;
        croak "The $caller\::$name method is protected"
            unless ( ( scalar caller() ) eq $caller || @check );

        goto &{$real_body};
    };

    $caller->meta->add_method( $name, $body );
}

1;

__END__

=head1 NAME

MooseX::MethodPrivate -

=head1 SYNOPSIS

  use MooseX::MethodPrivate;

=head1 DESCRIPTION

MooseX::MethodPrivate is

=head1 AUTHOR

franck cuny E<lt>franck.cuny {at} rtgi.frE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
