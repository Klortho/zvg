#!/usr/bin/env perl

use File::Path qw(make_path remove_tree);
use File::Copy;

my $random = int(rand(100000));
my $bundle = "zvg-bundle-" . $random;
print "$bundle\n";

my $dist = 'dist';
remove_tree($dist);
make_path($dist);

my @src = (
  'lib/ramda.js',
  'lib/raphael.js',
  'src/zvg.js',
);

my $cat_cmd = 'cat ' . join(' ', @src) . "> $dist/$bundle.js";
#print "cat_cmd: $cat_cmd\n";
system($cat_cmd);

my $index = 'index.html';
open(my $fh, '<:encoding(UTF-8)', $index)
  or die "Could not open file '$index' $!";
open(my $out, '>:encoding(UTF-8)', "$dist/$index")
  or die "Couldn't open $dist/$index for output: $!"; 

my $state = 0;
while (my $line = <$fh>) {
  my $print_line = 1;
  if ($state == 0) {
    if ($line =~ /<!-- start bundle -->/) {
      $line = "    <script src='$bundle.js'></script>\n";
      $state = 1;
    }
  }
  elsif ($state == 1) {
    $print_line = 0;
    if ($line =~ /<!-- end bundle -->/) {
      $state = 2;
    }
  }
  if ($print_line) {
    $line =~ s/href='src\//href='/;
    $line =~ s/src='src\//src='/;
    print $out $line;
  }
}

my @copy_srcs = (
  'src/style.css',
  'src/demo.js',
);
foreach my $src (@copy_srcs) {
  print "$src\n";
  copy($src, $dist) or die "Copy failed: $!";
}
