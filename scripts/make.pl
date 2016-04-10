#!/usr/bin/env perl

use Cwd 'abs_path';
use FindBin;
use File::Path qw(make_path remove_tree);
use File::Copy;

my $SCRIPTS = $FindBin::RealBin;
my $BASE = abs_path("$SCRIPTS/..");
my $DIST = "$BASE/dist";
my $SRC = "$BASE/src";
my $LIB = "$BASE/lib";

remove_tree($DIST);
make_path($DIST);

# Turn off cache busting - it won't work with jsfiddle (I'd have to 
# update it every time I made a change).
#my $random = int(rand(100000));
#my $bundle = "zvg-bundle-" . $random;
my $bundle = "zvg-bundle";

my @srcs = (
  "$LIB/ramda.js",
  "$LIB/raphael.js",
  "$SRC/zvg.js",
);

my $cat_cmd = 'cat ' . join(' ', @srcs) . "> $DIST/$bundle.js";
#print "cat_cmd: $cat_cmd\n";
system($cat_cmd);

my $index = 'index.html';
open(my $fh, '<:encoding(UTF-8)', "$BASE/$index")
  or die "Could not open file '$index' $!";
open(my $out, '>:encoding(UTF-8)', "$DIST/$index")
  or die "Couldn't open $DIST/$index for output: $!"; 

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
close($out);
close($fh);

my @copy_srcs = (
  "$SRC/style.css",
  "$SRC/demo.js",
);
foreach my $src (@copy_srcs) {
  print "$src\n";
  copy($src, $DIST) or die "Copy failed: $!";
}
