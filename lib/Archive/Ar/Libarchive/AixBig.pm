package Archive::Ar::Libarchive::AixBig;

use strict;
use warnings;

# ABSTRACT: Machinery for dealing with ar files of the AIX (big) format
our $VERSION = '2.05_02'; # VERSION


sub read
{
  my($ar, $sig, $fh) = @_;
  my $data = $sig . do { local $/; <$fh> };
  my $fl_hdr = get_fl_hdr($data);
  my $ar_hdr = $fl_hdr->first($data);
  while($ar_hdr)
  {
    my $name = $ar_hdr->ar_name;
    unless($name eq '')
    {
      $ar->add_data($name, $ar_hdr->data, {
        uid  => $ar_hdr->ar_uid,
        gid  => $ar_hdr->ar_gid,
        date => $ar_hdr->ar_date,
        mode => $ar_hdr->ar_mode,
      });
    }
    $ar_hdr = $ar_hdr->next($data, $fl_hdr);
  }
  return length $data;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Archive::Ar::Libarchive::AixBig - Machinery for dealing with ar files of the AIX (big) format

=head1 VERSION

version 2.05_02

=head1 SYNOPSIS

 use Archive::Ar::Libarchive;

=head1 DESCRIPTION

This module contains the machinery for dealing with ar archive files
that are in the AIX (big) format for L<Archive::Ar::Libarchive>.  It
doesn't provide any public interfaces.

=head1 SEE ALSO

=over 4

=item

L<Archive::Ar::Libarchive>

=item

L<Archive::Ar>

=back

=head1 AUTHOR

Graham Ollis <plicease@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
