# FILE SCAN
# Author: James Shank Jr.
# Date:   01/28/2016
# Scan's a text file (target.txt) line by line 
# for the presence of words from a wordlist (scanwords.txt)
# creating a log file (scanresults.txt) of all ocurrences found.
#
# Wordlist Structure:
# Column 1:  Word or phrase to be matched against
# Column 2:  Number of times the word or phrase was detected in the target file
# Column 3:  List of line numbers on which the word or phrase was detected in the target file
# Open Worddata file
open(WORDFILE, "<scanwords.txt") or die("Could not open scanwords.txt file");
# Read words to be searched for in line by line.  Each line is one word or phrase.
$numwords = 0;
while ($currword = <WORDFILE>)
	{
		chomp($currword);
		$wordlist[$numwords][1] = $currword;
		$wordlist[$numwords][2] = 0;
		$wordlist[$numwords][3] = "";
		++$numwords;
	}
# Open target file for scanning
open(SCANFILE, "<target.txt") or die("Could not open target.txt file");
# Start scanning process for each line
$linenum = 0;
while ($currline = <SCANFILE>)
	{
		chomp($currline);
		# Check each word in $wordlist against each line
		for($checkword = 0; $checkword < $numwords; ++$checkword)
			{
				if ($currline =~ m/\Q$wordlist[$checkword][1]\E/)
					{
						++$wordlist[$checkword][2];
						$wordlist[$checkword][3] = $wordlist[$checkword][3] . " " . $linenum;
					}
			}
		++$linenum;
	}
# Open Logfile for writing
open(LOGFILE, ">scanresults.txt") or die("Could not open scanresults.txt file");
# Output wordlist data to the file
for ($outword = 0; $outword <= $numwords; ++$outword)
	{
		print LOGFILE "$wordlist[$outword][1]\t$wordlist[$outword][2]\t$wordlist[$outword][3]\n";
	}
# House cleaning
close(WORDFILE);
close(SCANFILE);
close(LOGFILE);
