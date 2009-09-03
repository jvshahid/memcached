#!/usr/bin/perl

use strict;
use Test::More tests => 5;
use FindBin qw($Bin);
use lib "$Bin/lib";
use MemcachedTest;

my $server = new_memcached;
my $sock = $server->sock;

print $sock "get M195178362\r\n";
is (scalar <$sock>, "END\r\n", "missed as expected");

print $sock "add M195178362 2048 0 5\r\nhello\r\n";
is (scalar <$sock>, "STORED\r\n", "stored as expected");

print $sock "get M195178362\r\n";
is (scalar <$sock>, "VALUE M195178362 2048 5\r\n", "found the key");
is (scalar <$sock>, "hello\r\n", "found the value");
is (scalar <$sock>, "END\r\n", "found the end");
