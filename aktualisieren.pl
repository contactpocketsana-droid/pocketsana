#!/usr/bin/perl
# Übernimmt Datenschutzerklärung und Nutzungsbedingungen aus dem App-Projekt (legal/),
# damit Website und App immer denselben Text zeigen. Aufruf: perl aktualisieren.pl
use strict; use warnings; use utf8;
use FindBin;
my $quelle = "$FindBin::Bin/../meine-akte/legal";
my %seiten = (
  'datenschutzerklaerung.md' => ['datenschutz.md', 'Datenschutzerklärung', '/datenschutz'],
  'nutzungsbedingungen.md'   => ['nutzungsbedingungen.md', 'Nutzungsbedingungen', '/nutzungsbedingungen'],
);
for my $datei (sort keys %seiten) {
  my ($ziel, $titel, $pfad) = @{$seiten{$datei}};
  open my $f, '<:raw:encoding(UTF-8)', "$quelle/$datei" or die "$quelle/$datei: $!";
  local $/; my $text = <$f>; close $f;
  $text =~ s/\r\n/\n/g;
  die "$datei enthält Liquid-Syntax\n" if $text =~ /\{[{%]/;
  my $kopf = "---\nlayout: default\ntitle: $titel\npermalink: $pfad\n---\n\n";
  open my $w, '>:raw:encoding(UTF-8)', "$FindBin::Bin/$ziel" or die;
  print $w $kopf . $text; close $w;
  print "$ziel aktualisiert\n";
}
