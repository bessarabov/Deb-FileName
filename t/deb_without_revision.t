use Deb::FileName;

use Test::More;

my $tests = [

    {
        string => 'pool/main/x/xutils-dev/xutils-dev_7.5+2_amd64.deb',
        file_name => 'xutils-dev_7.5+2_amd64.deb',
        package_name => 'xutils-dev',
        version => '7.5+2',
        architecture => 'amd64',
    },

];

foreach my $test (@{$tests}) {

    my $deb = Deb::FileName->new(
        string => $test->{string},
    );

    is( $deb->get_file_name(), $test->{file_name}, 'get_file_name()' );
    is( $deb->get_package_name(), $test->{package_name}, 'get_package_name()' );
    is( $deb->get_version(), $test->{version}, 'get_version()' );
    ok( not($deb->has_revision()), 'has_revision()' );

    eval {
        my $revision = $deb->get_revision();
    };

    my $message = "Got error while trying to execute has_revision()";

    if ($@) {
        pass($message);
    } else {
        fail($message);
    }

    is( $deb->get_architecture(), $test->{architecture}, 'get_architecture()' );

}

done_testing();
