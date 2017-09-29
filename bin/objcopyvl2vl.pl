#!/usr/bin/perl

use POSIX qw(strtoul);

$infile="";
$outfile="";
$offset=0;
$bytesperword=4;
$bigendian=1;

for ($i=0; $i<=$#ARGV; $i++) {
	if ($ARGV[$i] =~ /^-/) {
		if ($ARGV[$i] eq "-offset") {
			$i++;
			$offset=strtoul($ARGV[$i], 0);
			print "offset=$offset\n";
		} elsif ($ARGV[$i] eq "-width") {
			$i++;
			$bytesperword = $ARGV[$i] / 8;
		} elsif ($ARGV[$i] eq "-be") {
			$bigendian = 1;
		} elsif ($ARGV[$i] eq "-le") {
			$bigendian = 0;
		} else {
			die "unknown option $ARGV[$i]";
		}
	} else {
		if ($infile eq "") {
			$infile = $ARGV[$i];
		} elsif ($outfile eq "") {
			$outfile = $ARGV[$i];
		} else {
			die "unknown argument $ARGV[$i]";
		}
	}
}

open(FH, "<", $infile) || die "cannot open file";

$out="";

$line = <FH>;

while (1) {

	print "LINE: $line\n";
	
	unless ($line =~ /^@/) {
		die "Unknown record: $line";
		last;
	}

	# Parse address and convert to word address
	$wordaddr = hex(substr($line, 1));
	$wordaddr -= $offset;
    $wordaddr /= $bytesperword;

	# Display as word address
	$out .= sprintf("@%08x\n", $wordaddr);

	# Read data lines until EOF or get @
	while (<FH>) {
		$line = $_;
		unless ($line =~ /^@/) {
			# Process into individual-word writes
			@elems = split(/\s+/, $line);
			for ($i=0; $i<=$#elems; $i+=$bytesperword) {
				if ($bigendian) {
					for ($j=0; $j<$bytesperword; $j++) {
						$out .= $elems[$i+$j];
					}
					$out .= "\n";
				} else {
					for ($j=$bytesperword-1; $j>=0; $j--) {
						$out .= $elems[$i+$j];
					}
					$out .= "\n";
				}
			}
			$line = "";
		} else {
			# Continue
			last;
		}
	}

    if ($line eq "") {
		last;
	}
}

close(FH);

open(FH, ">", $outfile) || die "cannot open file";
print FH "$out";
close(FH);

