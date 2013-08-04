use strict;
use warnings;

package Deb::FileName;

# ABSTRACT: parse strings like 'foo_1.0.0-1_all.deb'

=encoding UTF-8

=head1 SYNOPSIS

File containing Debian software package has file name under the standard:

    <package_name>_<version_number>-<revision_number>_<architecture>.deb

Deb::FileName gives the easy way to parse file name:

    use Deb::FileName;

    my $deb = Deb::FileName->new('perl_5.14.2-21_amd64.deb');

    $deb->get_package_name();       # 'perl'
    $deb->get_version();            # '5.14.2'
    $deb->get_revision();           # '21'
    $deb->get_architecture();       # 'amd64'

    $deb->get_name();   # 'perl_5.14.2-21_amd64.deb'

In case the filaname is incorrect the constractor new() will die.

=head1 DESCRIPTION

Descripton of the Debian package file name:
L<http://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics#s-pkgname>.

=cut

use Carp;

my $true = 1;
my $false = '';

=head1 METHODS

=head2 new

The constractor. It should recieve one parameter with the string describing
deb file name. It returns the object if the string is correct or dies.

The constractor can recieve file name without path:

    my $deb = Deb::FileName->new('perl_5.14.2-21_amd64.deb');

Or it can recieve file name with relative or absolute path:

    my $deb = Deb::FileName->new('cache/apt/archives/libdata-printer-perl_0.35-1_amd64.deb');

Or it can recieve file name in url:

    my $deb = Deb::FileName->new('http://mirror.leaseweb.com/ubuntu//pool/main/libw/libwww-perl/libwww-perl_6.04-1_all.deb');

In case deb file name is incorrect the new() dies.

=cut

sub new {
    my ($class, $string) = @_;

    my $self = {};
    bless $self, $class;

    $self->__parse_string($string);

    return $self;
}

=head2 get_name

Returns deb file name.

    my $deb = Deb::FileName->new('http://mirror.leaseweb.com/ubuntu//pool/main/libw/libwww-perl/libwww-perl_6.04-1_all.deb');
    $deb->get_name();   # 'libwww-perl_6.04-1_all.deb'

=cut

sub get_name {
    my ($self) = @_;

    return $self->{__name};
}

=head2 get_package_name

=cut

sub get_package_name {
    my ($self) = @_;

    return $self->{__package_name};
}

sub __check_package_name {
    my ($self, $smth) = @_;

    if (1) {
        return $smth;
    } else {
        croak "Package name is incorrect. Stopped";
    }

}

=head2 get_version

=cut

sub get_version {
    my ($self) = @_;

    return $self->{__version};
}

sub __check_version {
    my ($self, $smth) = @_;

    if (1) {
        return $smth;
    } else {
        croak "Version is incorrect. Stopped";
    }

}

=head2 get_revision

=cut

sub get_revision {
    my ($self) = @_;

    return $self->{__revision};
}

sub __check_revision {
    my ($self, $smth) = @_;

    if (1) {
        return $smth;
    } else {
        croak "Revision is incorrect. Stopped";
    }

}

=head2 get_architecture

=cut

sub get_architecture {
    my ($self) = @_;

    return $self->{__architecture};
}

sub __check_architecture {
    my ($self, $smth) = @_;

    if (1) {
        return $smth;
    } else {
        croak "Architecture is incorrect. Stopped";
    }

}

sub __parse_string {
    my ($self, $string) = @_;

    croak("Expected to recieve string. Stopped") if not defined $string;

    my $check_result = $string =~ /
        (
            ([^_\/]+)          # name
            _
            ([^_\/]+)          # version
            -
            ([^_\/]+)          # revision
            _
            ([^_\/]+)          # architecture
            \.deb
        )
        $
    /x;

    if ($check_result) {

        $self->{__name} = $1;
        $self->{__package_name} = $self->__check_package_name($2);
        $self->{__version} = $self->__check_version($3);
        $self->{__revision} = $self->__check_revision($4);
        $self->{__architecture} = $self->__check_architecture($5);

    } else {
        croak "String '$string' is not a valid deb filename. Stopped";
    }

    return $false;
}

=head1 SEE ALSO

=over

=item * L<Regexp::Common::debian>

=back

=head1 SOURCE CODE

The source code for this module is hosted on GitHub
L<https://github.com/bessarabov/Deb-FileName>

=head1 BUGS

Please report any bugs or feature requests in GitHub Issues
L<https://github.com/bessarabov/Deb-FileName/issues>

=cut

1;