use IO::Socket::INET;

my @servers = ('1.1.1.1', '2.2.2.2');
my $port = "7777";
my $logfile = ".api.log";

$| = 1;
print "SERVER_IP \t | REQUEST \t | NETWORKSIZE\n";
sub noconnect {
	print "Cant connect to $_ reached timeout..\n";
	goto nextconn;
}

foreach (@servers) {
my $socket = new IO::Socket::INET (
    PeerHost => $_,
    PeerPort => $port,
    Proto => 'tcp',
    Timeout => '10',
) or noconnect;


my $req = $ARGV[0];
my $size = $socket->send($req);

print "$_ \t | $req \t | $size\n";
open (FILE, ">>$logfile");
print FILE "$_ \t | $req \t | $size\n";
close FILE;
shutdown($socket, 1);

$socket->close();
nextconn:
}
