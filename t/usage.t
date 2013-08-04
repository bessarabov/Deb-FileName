use Deb::FileName;

use Test::More;

my $tests = [
    {
        string => 'perl_5.14.2-21_amd64.deb',
        name => 'perl_5.14.2-21_amd64.deb',
        package_name => 'perl',
        version => '5.14.2',
        revision => '21',
        architecture => 'amd64',
    },
    {
        string => 'http://ubuntu.mirror.iweb.ca//pool/main/p/perl/perl_5.14.2-21_amd64.deb',
        name => 'perl_5.14.2-21_amd64.deb',
        package_name => 'perl',
        version => '5.14.2',
        revision => '21',
        architecture => 'amd64',
    },
    {
        string => 'http://ftp.us.debian.org/debian/pool/main/libd/libdist-zilla-perl/libdist-zilla-perl_4.300020-1_all.deb',
        name => 'libdist-zilla-perl_4.300020-1_all.deb',
        package_name => 'libdist-zilla-perl',
        version => '4.300020',
        revision => '1',
        architecture => 'all',
    },
    {
        string => 'http://mirror.leaseweb.com/ubuntu//pool/main/libw/libwww-perl/libwww-perl_6.04-1_all.deb',
        name => 'libwww-perl_6.04-1_all.deb',
        package_name => 'libwww-perl',
        version => '6.04',
        revision => '1',
        architecture => 'all',
    },
    {
        string => 'cache/apt/archives/libdata-printer-perl_0.35-1_amd64.deb',
        name => 'libdata-printer-perl_0.35-1_amd64.deb',
        package_name => 'libdata-printer-perl',
        version => '0.35',
        revision => '1',
        architecture => 'amd64',
    },


];

foreach my $test (@{$tests}) {

    my $deb = Deb::FileName->new(
        string => $test->{string},
    );

    is( $deb->get_name(), $test->{name}, 'get_name()',);
    is( $deb->get_package_name(), $test->{package_name}, 'get_package_name()',);
    is( $deb->get_version(), $test->{version}, 'get_version()',);
    is( $deb->get_revision(), $test->{revision}, 'get_revision()',);
    is( $deb->get_architecture(), $test->{architecture}, 'get_architecture()');

}

done_testing();
