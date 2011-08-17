

my $nonverbose = 0;

my $directory = ".";
opendir (DIR, $directory) || die $!;

print("Reading in [$directory]\n") unless $nonverbose;

my @files;
while(my $file = readdir(DIR))
{
	print("$file\n");
	# push(@files,$file) unless $file eq __FILE__;
	push(@files,$file) if ($file =~ m/bob.*burgers/i);
}

closedir(DIR);


print("Here are the interesting files:\n") unless $nonverbose;

my %episodes;
my $showname = "Bob's_Burgers";
my @finalepisodes;
for(@files)
{
	#For: OneDDL.com-Bobs.Burgers.S01E07.HDTV.XviD-LOL
	$_ =~ m/(s\d+)(e\d+)/i;
	my $season = $1;
	my $episode = $2;
	
	#For: OneDDL.com-bobs.burgers.106.hdtv-lol
	$_ =~ m/(\d)(\d{2})/i;
	my $season = $1;
	my $episode = $2;

	#For: filetype
	$_ =~ m/(\.[^\.]+)$/i;
	my $filetype = $1;
	print("Season:[$season] | Episode:[$episode] | FileType:[$filetype]\n");


	$episodes{$_} = "Bob's_Burgers_$season$episode$filetype" if($filetype =~ ".mkv");
	
}

print("The Episodes:\n");

 
use Cwd;
my $currentDir = getcwd;
$currentDir =~ m/\/([^\/]+$)/;
my $logfileName = $1."_rename.csv";
$logfileName =~ s/\s/_/g;
open(LOGFILE, ">", $logfileName) || print $!;
print(LOGFILE "original,renamed,status\n");
for(keys(%episodes))
{
	# my $status = (rename($_,$episodes{$_}))
	# my $status = (-e $_)?"success":"failure";
	my $status = (rename($_,$episodes{$_}))?"success":"failure";
	# {
		# print("$_ -> $episodes{$_}\n");
		# print(LOGFILE "$_,$episodes{$_},success\n");
	# }
	# else
	# {
		# print("can't rename:\t$_ -> $episodes{$_}\n");
	# }
	print(LOGFILE "$_,$episodes{$_},$status\n");
}
close LOGFILE;



print("\n");

print("done");

__END__