# anagrams perl solution

my $dictionary = "";

if (@ARGV) {
	$dictionary = $ARGV[0]
}
else { # No argument provided, exit and give message
	print "Please provide a valid dictionary file\n";
	exit;
}

# Initialize anagrams hash and open the dictionary file
my %anagrams = ();

open DICT, $dictionary or die "Cannot open provided file: $dictionary $!\n";

sub makeKey {
	$_ = $_[0];
	s/\W//g; # Replaces non-alphanumeric characters 
	# This line casts the letters to lower case and sorts them
	return (join '', sort split(//,lc));
}

while (<DICT>) {
	chomp;
	my $dictword = $_;
	my $keyword = &makeKey($_);
	# Go to next line if < 4 characters in the word (ignoring apostrophes)
	next if (length $keyword < 4);
	if ($anagrams{$keyword}) {
		# Seperate values with commas if another value already exists
		$anagrams{$keyword} = join (", ", $anagrams{$keyword}, $dictword);
	}
	else {
		# This is the first value for the key, no comma
		$anagrams{$keyword} = $dictword;
	}
}

close DICT;

while (my ($key, $val) = each %anagrams) {
	# Count number of commas + 1
	my $count = ($val =~ tr/\,//) + 1;
	if ($count >= (length $key)) {
		# Only print if the number of words is >= the number of letters
		print $val,"\n";
	}
}
