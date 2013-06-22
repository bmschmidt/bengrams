#!/usr/bin/perl

use strict;
use warnings;
use threads;
use Thread::Queue;

my $output = Thread::Queue->new(); 

my @threads;

foreach my $file (@ARGV) {
    my $reading = threads->create(\&queueUpFile,$file);
    push(@threads,$reading);
}


sub queueUpFile {
    my $item = pop;
    open (FILE,$item);
    my @preQueue;
    while (my $line = <FILE>) {
	push(@preQueue,$line);
	if($#preQueue>1000) {
	    $output->enqueue(\@preQueue);
	    @preQueue=();
	}
	#sleep 1 if ($output->pending()>=10000)
    }
    $output->enqueue(\@preQueue);
    $output->enqueue("\f");
    return 1;
}

my $ThreadsRemaining = $#threads +1;

while ($ThreadsRemaining) {
    my $writeline = $output->dequeue();
    if ($writeline eq "\f") {
	$ThreadsRemaining = $ThreadsRemaining-1 ;
    } else {
	print $writeline;
    }
}

