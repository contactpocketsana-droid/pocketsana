#!/usr/bin/perl
# Übernimmt Datenschutzerklärung und Nutzungsbedingungen aus dem App-Projekt (legal/),
# damit Website und App denselben Text zeigen. Aufruf: perl aktualisieren.pl
# Owner-Entscheid 15.10.2026 (ersetzt 06.10.2026 b): Die Website zeigt die GEMEINSAME Fassung
# (Android + iPhone gekennzeichnet) vom Zweig multiplatform. Gelesen wird nur per `git show`
# aus dem Repo ../meine-akte (der Arbeitsbaum dort wird nicht angefasst). Die App auf main
# zeigt weiterhin die reine Android-Fassung.
use strict; use warnings; use utf8;
use FindBin;
my $repo = "$FindBin::Bin/../meine-akte";
my $ref  = 'multiplatform';
my %seiten = (
  'datenschutzerklaerung.md' => ['datenschutz.md', 'Datenschutzerklärung', '/datenschutz'],
  'nutzungsbedingungen.md'   => ['nutzungsbedingungen.md', 'Nutzungsbedingungen', '/nutzungsbedingungen'],
);
for my $datei (sort keys %seiten) {
  my ($ziel, $titel, $pfad) = @{$seiten{$datei}};
  open my $f, '-|:raw:encoding(UTF-8)', 'git', '-C', $repo, 'show', "$ref:legal/$datei"
    or die "git show $ref:legal/$datei: $!";
  local $/; my $text = <$f>; close $f or die "git show $ref:legal/$datei fehlgeschlagen\n";
  die "$datei leer\n" unless length $text;
  $text =~ s/\r\n/\n/g;
  $text =~ s/<!--.*?-->\n*//gs;   # interne Hinweise nicht in den Seitenquelltext übernehmen
  die "$datei enthält Liquid-Syntax\n" if $text =~ /\{[{%]/;
  my $kopf = "---\nlayout: default\ntitle: $titel\npermalink: $pfad\n---\n\n";
  open my $w, '>:raw:encoding(UTF-8)', "$FindBin::Bin/$ziel" or die;
  print $w $kopf . $text; close $w;
  print "$ziel aktualisiert ($ref)\n";
}
