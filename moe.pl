#!/usr/bin/env perl
use constant MoeDatabase => "./development.sqlite3";
for my $arg (@ARGV) {
    my $col = 'title';
    if ($arg =~ /%$/) {
        $arg = "%$arg";
        $col = 'def';
    }
    $arg .= '%' unless $arg =~ s/\$$//;
    system sqlite3 => MoeDatabase, qq[
        SELECT '' || title || '\t' || heteronyms.bopomofo || '\n» ' || group_concat(
            def, '\n» '
        ) || '\n'
          FROM entries
          JOIN heteronyms ON entry_id = entries.id
          JOIN definitions ON heteronym_id = heteronyms.id
         WHERE $col LIKE '$arg'
      GROUP BY title, heteronyms.bopomofo;
    ];
}
