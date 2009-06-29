use inc::Module::Install;
name 'MooseX-MethodPrivate';
all_from 'lib/MooseX/MethodPrivate.pm';

# requires '';
requires 'Moose';
requires 'Test::Class';
requires 'Test::Exception';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
