# Copyright (c) 2015  Timm Murray
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, 
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright 
#       notice, this list of conditions and the following disclaimer in the 
#       documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.
use Test::More tests => 10;
use v5.14;
use warnings;
use Device::Spektrum::Packet;


my %values = (
    throttle => 170,
    aileron => 200,
    elevator => 250,
    rudder => 800,
    gear => SPEKTRUM_LOW,
    aux1 => SPEKTRUM_MIDDLE,
    aux2 => SPEKTRUM_HIGH,
);
my $packet = Device::Spektrum::Packet->new({
    %values,
});
isa_ok( $packet => 'Device::Spektrum::Packet' );

my $encoded_packet = $packet->encode_packet;
my @encoded_packet = unpack 'C*', $encoded_packet;

cmp_ok( to_16bit( @encoded_packet[0,1] ), '==', 0x0100, "Packet header" );
@encoded_packet = @encoded_packet[ 2 .. $#encoded_packet ];


my %expected_values = (
    map( { $_ => 1 }
        to_16bit( (0x00 << 2), $values{throttle} ),
        to_16bit( (0x01 << 2), $values{aileron} ),
        to_16bit( (0x02 << 2), $values{elevator} ),
        to_16bit( (0x03 << 2), $values{rudder} ),
        to_16bit( (0x04 << 2), $values{gear} ),
        to_16bit( (0x05 << 2), $values{aux1} ),
        to_16bit( (0x06 << 2), $values{aux2} ),
    )
);
while( @encoded_packet ) {
    my $byte1 = shift @encoded_packet;
    my $byte2 = shift @encoded_packet;
    my $val = to_16bit( $byte1, $byte2 );

    if( exists $expected_values{$val} ) {
        pass( "Hit value '$val'" );
        delete $expected_values{$val};
    }
    else {
        fail( "Hit unexpected value '$val'" );
    }
}

ok(! %expected_values, "All expected values hit" );


sub to_16bit
{
    my ($byte1, $byte2) = @_;
    my $val = ($byte1 << 8) | $byte2;
    return $val;
}
