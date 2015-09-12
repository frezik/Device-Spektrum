# Copyright (c) 2015,  Timm Murray
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are 
# met:
# 
#     * Redistributions of source code must retain the above copyright 
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright 
#       notice, this list of conditions and the following disclaimer in 
#       the documentation and/or other materials provided with the 
#       distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED 
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
package Device::Spektrum::Packet;

use v5.14;
use warnings;
use Moose;
use namespace::autoclean;
use base 'Exporter';

use constant HEADER => 0x0100;
use constant {
    THROTTLE_ID => 0x00,
    AILERON_ID => 0x01,
    ELEVATOR_ID => 0x02,
    RUDDER_ID => 0x03,
    GEAR_ID => 0x04,
    AUX1_ID => 0x05,
    AUX2_ID => 0x06,
};
use constant SPEKTRUM_LOW => 170;
use constant SPEKTRUM_HIGH => 853;
use constant SPEKTRUM_MIDDLE => int( ((SPEKTRUM_HIGH - SPEKTRUM_LOW) / 2)
    + SPEKTRUM_LOW );

my @EXPORT_SYM = qw( SPEKTRUM_LOW SPEKTRUM_MIDDLE SPEKTRUM_HIGH );
our @EXPORT_OK = @EXPORT_SYM;
our @EXPORT = @EXPORT_SYM;


has $_ =>  (
    is => 'ro',
    isa => 'Int',
    required => 1,
) for qw{
    throttle aileron elevator rudder gear aux1 aux2
};


sub encode_packet
{
    my ($self) = @_;
    my $packet = pack( 'n*',
        HEADER,
        $self->_encode( $self->THROTTLE_ID, $self->throttle ),
        $self->_encode( $self->AILERON_ID, $self->aileron ),
        $self->_encode( $self->ELEVATOR_ID, $self->elevator ),
        $self->_encode( $self->RUDDER_ID, $self->rudder ),
        $self->_encode( $self->GEAR_ID, $self->gear ),
        $self->_encode( $self->AUX1_ID, $self->aux1 ),
        $self->_encode( $self->AUX2_ID, $self->aux2 ),
    );
    return $packet;
}


sub _encode
{
    my ($self, $id, $val) = @_;
    my $encoded_val = ($id << 10) | $val;
    return $encoded_val;
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
__END__


=head1 NAME

  Device::Spektrum::Packet - Represent a packet of Spektrum data

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head1 LICENSE

Copyright (c) 2015,  Timm Murray
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are 
permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of 
      conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of 
      conditions and the following disclaimer in the documentation and/or other materials 
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS 
OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut
