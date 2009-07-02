use inc::Module::Install;
name 'MooseX-MethodPrivate';
all_from 'lib/MooseX/MethodPrivate.pm';

# requires '';
requires 'Moose';
requires 'Carp';
requires 'Test::Exception';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
repository 'http://github.com/franckcuny/MooseX--MethodPrivate/tree/master';
WriteAll;
