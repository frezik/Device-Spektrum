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
package Device::Spektrum;

use v5.14;
use warnings;
use Moose;
use namespace::autoclean;

# ABSTRACT: Send packets compatible with the Spektrum RC protoocol


no Moose;
__PACKAGE__->meta->make_immutable;
1;
__END__


=head1 NAME

  Device::Spektrum - Send packets compatible with the Spektrum RC protocol

=head1 SYNOPSIS

    use Device::Spektrum::Packet;
    my $packet = Device::Spektrum::Packet->new({
        throttle => 170,
        aileron => 200,
        elevator => 250,
        rudder => 800,
        gear => SPEKTRUM_LOW,
        aux1 => SPEKTRUM_MIDDLE,
        aux2 => SPEKTRUM_HIGH,
    });
    
    my $encoded_packet = $packet->encode_packet;

=head1 DESCRIPTION

Spektrum is a serial protocol that is compatible with many radio controlled flight 
controllers. Using this module allows you to craft packets compatible with these 
flight controllers. It supports up to 7 channels.

Data is sent over a serial connection with one start bit, 8 data bits, LSB, no parity, 
and one stop bit, all at 115.9Kbps.  One wrinkle is that the signal is inverted from the 
usual RS232 signal. If you want to connect your computer as if it were a true Spektrum 
receiver, you will need an inverter cable.

Many Open Source flight controllers also require an inverter cable to receive Spektrum 
signals (check your flight controller's manual to see if this is the case, but it almost 
always is). For this, you will need two inverter cables to bring the signal back to what 
it was.  Alternatively, you can use a straight cable, if you want to do it the lazy way.

Most of the interesting parts of the API is in L<Device::Spektrum::Packet>, so read those 
docs for details.

=head1 SEE ALSO

Protocol description: L<http://www.desertrc.com/spektrum_protocol.htm>

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
