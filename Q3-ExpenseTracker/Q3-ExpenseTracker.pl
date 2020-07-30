use strict;
use warnings;



my @revenue;
my @expenditure;
my @balance;



sub Revenue{
	print "You can now check you Revenue sheet\n";
	for (@revenue)
	{
		print "$_\t" for @$_;
		print "\n";
	}
}

sub Expenditure{
	print "You can now check you Expenditure sheet\n";
	for (@expenditure)
	{
		print "$_\t" for @$_;
		print "\n";
	}
}

sub Balance{
	print "You can now check you Balance sheet\n";
	for (@balance)
	{
		print "$_\t" for @$_;
		print "\n";
	}
}

sub Add{
	print "You can now add some amount\n";
	my $d = localtime();
	#print $d;
	my @DT = split ' ', $d;
	print "How much amount do you want to add?: ";
	my $amount = <STDIN>;
	print "Remarks?: ";
	my $remark = <STDIN>;
	my $date = join ' ', ($DT[1], $DT[2], $DT[4]);
	
	my @entry = ($date, $DT[3], $amount, $remark);
	push @revenue, \@entry;
	
	my $sum = 0;
	for (@revenue)
	{
		$sum = $sum + $_->[2];
	}
	print $sum;
	
	#also push the data to file
}

sub Withdraw{
	print "You can now withdraw some amount\n";
	my $d = localtime();
	print $d;
	
}


sub Check{
	print "What do you want to check?\n";
	print "A. Revenue sheet\n";
	print "B. Expenditure sheet\n";
	print "C. Balance sheet\n";
	my $response = <STDIN>;

	if($response =~ m/a/i)
	{
		Revenue;
	}
	elsif($response =~ m/b/i)
	{
		Expenditure;
	}
	elsif($response =~ m/c/i)
	{
		Balance;
	}
	else
	{
		print "Invalid Input!\n";
	}
}

sub Update{
	print "Do you want to add or withdraw amount? \n";
	print "A. Add Amount\n";
	print "B. Withdraw Amount\n";
	my $response = <STDIN>;
	
	if($response =~ m/a/i)
	{
		Add;
	}
	elsif($response =~ m/b/i)
	{
		Withdraw;
	}
	else
	{
		print "Invalid Input!\n";
	}
}
	

print "Do you want to check the current status or make changes?\n";
print "A. Check status\n";
print "B. Update account\n";

my $action = <STDIN>;

if($action =~ m/a/i)
{
	Check;
}
elsif($action =~ m/b/i)
{
	Update;
}
else
{
	print "Invalid Input!\n";
}

