#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Ukigumo::Server::Schema;
use Path::Tiny;

for my $dbm (qw/MySQL SQLite/) {
    my $ddl = Ukigumo::Server::Schema->translate_to($dbm);
    $ddl =~ s/\A\s+//ms;
    $ddl =~ s/\s+\z//;
    $ddl =~ s/^--.*?\n//msg;
    $ddl =~ s/^CREATE ([A-Z ]+)/CREATE ${1}IF NOT EXISTS /msg;

    $ddl = qq[-- DON'T EDIT MANNUALLY! THIS FILE IS GENERATED BY author/create_ddl.pl\n].$ddl;

    my $file = lc $dbm . '.sql';

    $file = path('share')->child('sql', $file);
    $file->spew_utf8($ddl);
}

my $translator = Ukigumo::Server::Schema->translator;
$translator->producer('Teng', package => 'Ukigumo::Server::DB::Schema');
my $content = qq[# DON'T EDIT MANNUALLY! THIS FILE IS GENERATED BY author/create_ddl.pl\n]. $translator->translate;

my $file = path('lib')->child(qw/Ukigumo Server DB Schema.pm/);
$file->spew_utf8($content);

print "done\n";
