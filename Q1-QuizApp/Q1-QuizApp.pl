#Quiz Application
use warnings;
use strict;

#declaring hash
my %cred;
open RJ, '+< details.txt' or die $!;
my %quest;
open QA, '+< Q&A.txt' or die $!;

#read from file to hash
while(<RJ>){
	chomp $_;
	my ($ADMIN, $UID, $PASS, @DET) = split ':', $_; 		#Other details like-phone number, emailID, gender
	$cred{$UID} = [$PASS, $ADMIN];
}


while(<QA>){
	chomp $_;
	my ($QUES, $ANS) = split ':', $_; 
	$quest{$QUES} = $ANS;
}



sub Quiz{
	print "You can now play the Quiz\n";
	
	my $result = 0;
	
	if(!keys %quest)
	{
		my $Q1 = 'What is three fifth of 100?';
		my $Q2 = 'How many years are there in a decade?';
		my $Q3 = 'What is the cube root of 1331?';
		my $Q4 = 'The wages of 10 workers for a six-day week is $ 1200. What are the one day’s wages of 4 workers?';
		my $Q5 = 'What is the square root of 0.0081?';
		
		my @Q = ($Q1, $Q2, $Q3, $Q4, $Q5); 
		
		$quest{$Q1} = 60;
		$quest{$Q2} = 10;
		$quest{$Q3} = 11;
		$quest{$Q4} = 80;
		$quest{$Q5} = 0.09;
				
		print QA "$_:$quest{$_}\n" for(keys %quest);
		
	}
	
	
	for(my $i=0; $i<=4; $i++)
	{
		my $val = (keys %quest)[rand keys %quest];
		print "$val ";
		my $answer = <STDIN>;
		if($answer == $quest{$val})
		{
			$result++;
			print "Correct\n";
		}
		else
		{
			print "Incorrect! Correct answer is $quest{$val}\n";
		}
	}
	print "Your Score is: $result";
}

sub Quiz_Edit{
	print "You can now edit the Quiz\n";
	print "How many questions do you want to add? ";
	my $count = <STDIN>;
	while($count > 0){
		print "Enter the question: ";
		my $Q = <STDIN>;
		chomp $Q;
		print "Enter the answer: ";
		my $A = <STDIN>;
		chomp $A;
		
		print QA "\n$Q:$A";
		$count--;
	}			
}


#Login using Username and Password.
sub Login{
	print 'Enter Username: ';
	my $UID = <STDIN>;
	chomp $UID;
	print 'Enter Password: ';
	my $PASS = <STDIN>;
	chomp $PASS;
	return($UID, $PASS); 
}

#SignUp using Username, Password and other details.
sub SignUp{
	print 'Are you an Admin? [Y/N]: ';
	my $ADMIN = <STDIN>;
	chomp $ADMIN;
	print 'Enter Username: ';
	my $UID = <STDIN>;
	chomp $UID;
	print 'Enter Password: ';
	my $PASS = <STDIN>;
	chomp $PASS;
	print 'Enter Phone Number: ';
	my $PHNO = <STDIN>;
	chomp $PHNO;
#	print 'Enter Email-ID: ';
#	my $EMAIL = <STDIN>;
#	chomp $EMAIL;
	print 'Enter Gender: ';
	my $GENDER = <STDIN>;
	chomp $GENDER;
	#my @s = ($PHNO, $EMAIL, $GENDER);
	my @s = ($PHNO, $GENDER);
	my $DET = join ':', @s;
	return($ADMIN, $UID, $PASS, $DET); 
}



print "Already have an account? ";
my $response = <STDIN>;
my $UID1;
my $PASS1;
my $ADMIN1;
my $DET1;


#Login
if ($response =~ m/yes/i){
	($UID1, $PASS1) = Login;	

	if (exists($cred{$UID1})){
		while((($cred{$UID1}[0] cmp $PASS1) != 0)){
			print "Wrong Password: Try Again\n";
			($UID1, $PASS1) = Login;
		}	
	}
	else
	{
		print "Wrong Username: Try Again\n";
		exit;
	}
	print "Login Successful\n";
}

#SignUp
elsif ($response =~ m/no/i){
	($ADMIN1, $UID1, $PASS1, $DET1) = SignUp;
	while (exists $cred{$UID1}){
		print "Username Already Exists! Try to login or choose another username\n";
		($ADMIN1, $UID1, $PASS1, $DET1) = SignUp;		
	}	
	$cred{$UID1} = [$PASS1, $ADMIN1];
	print "SignUp Successful\n";
	print RJ "\n$ADMIN1:$UID1:$PASS1:$DET1"; #add other details
}
else{
	print "Invalid Input\n";
	exit;
}


#See if admin-- ask if he wants to give the quiz or edit the quiz---direct to suitable subroutine
if($cred{$UID1}[1] =~ m/Y/i)
{
	print "Do you want to edit the quiz or play the quiz?\n";
	print "Type 'E' to edit OR type 'P' to play\n";
	my $in = <STDIN>;
	if($in =~ m/e/i)
	{
		Quiz_Edit;
	}
	elsif($in =~ m/p/i)
	{
		Quiz;
	}
	else
	{
		print "Invalid Input.\n";
	}
}
else
{
	Quiz;
}


close RJ;
close QA;