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

    my $deb = Deb::FileName->new(
        string => 'perl_5.14.2-21_amd64.deb',
    );

    $deb->get_package_name();       # 'perl'
    $deb->get_version();            # '5.14.2'
    $deb->get_revision();           # '21'
    $deb->get_architecture();       # 'amd64'

    $deb->get_file_name();   # 'perl_5.14.2-21_amd64.deb'

In case the filaname is incorrect the constractor new() will die.

=head1 DESCRIPTION

Descripton of the Debian package file name:
L<http://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics#s-pkgname>.

Deb::FileName uses Semantic Versioning standart for version numbers. Please
visit L<http://semver.org/> to find out all about this great thing.

=cut

use Carp;

my $true = 1;
my $false = '';

=head1 METHODS

=head2 new

The constractor. It should recieve string describing deb file name. It returns
the object if the string is correct or dies.

The constractor can recieve file name without path:

    my $deb = Deb::FileName->new(
        string => 'perl_5.14.2-21_amd64.deb',
    );

Or it can recieve file name with relative or absolute path:

    my $deb = Deb::FileName->new(
        string => 'cache/apt/archives/libdata-printer-perl_0.35-1_amd64.deb',
    );

Or it can recieve url:

    my $deb = Deb::FileName->new(
        string => 'http://mirror.leaseweb.com/ubuntu//pool/main/libw/libwww-perl/libwww-perl_6.04-1_all.deb',
    );

In case deb file name is incorrect the new() dies.

=cut

sub new {
    my ($class, %params) = @_;

    my $self = {};
    bless $self, $class;

    $self->__parse_string($params{string});

    return $self;
}

=head2 get_file_name

Returns deb file name.

    my $deb = Deb::FileName->new(
        string => 'http://mirror.leaseweb.com/ubuntu//pool/main/libw/libwww-perl/libwww-perl_6.04-1_all.deb',
    );
    $deb->get_file_name();   # 'libwww-perl_6.04-1_all.deb'

=cut

sub get_file_name {
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

=head2 has_revision

=cut

sub has_revision {
    my ($self) = @_;

    my $result = $self->{__has_revision} ? $true : $false;

    return $result;
}


=head2 get_revision

=cut

sub get_revision {
    my ($self) = @_;

    if ($self->has_revision()) {
        return $self->{__revision};
    } else {
        croak "There is no revision in deb file name. Stopped";
    }
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

    my $re_strict = qr/
        (?<name>
            (?<package_name>[^_\/]+)
            _
            (?<version>[^_\/]+)
            -
            (?<revision>[^_\/]+)
            _
            (?<architecture>[^_\/]+)
            \.deb
        )
        $
    /x;

    # it is not under standard, but revisoin is very often missing in real
    # life repository
    my $re_without_revision= qr/
        (?<name>
            (?<package_name>[^_\/]+)
            _
            (?<version>[^_\/]+)
            _
            (?<architecture>[^_\/]+)
            \.deb
        )
        $
    /x;

    if ($string =~ $re_strict) {

        $self->{__name} = $+{name};
        $self->{__package_name} = $self->__check_package_name($+{package_name});
        $self->{__version} = $self->__check_version($+{version});
        $self->{__revision} = $self->__check_revision($+{revision});
        $self->{__architecture} = $self->__check_architecture($+{architecture});

        $self->{__has_revision} = $true;

    } elsif ($string =~ $re_without_revision) {

        $self->{__name} = $+{name};
        $self->{__package_name} = $self->__check_package_name($+{package_name});
        $self->{__version} = $self->__check_version($+{version});
        $self->{__architecture} = $self->__check_architecture($+{architecture});

        $self->{__has_revision} = $false;

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
