use Deb::FileName;

use Test::More;

my $deb;

eval {
    $deb = Deb::FileName->new();
};

my $message = "Got error while trying to create object without parameters";

if ($@) {
    pass($message);
} else {
    fail($message);
}

done_testing();
