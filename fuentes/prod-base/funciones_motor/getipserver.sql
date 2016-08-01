CREATE OR REPLACE FUNCTION public.getipserver(ifname text)
 RETURNS text
 LANGUAGE plpythonu
AS $function$

import socket
import fcntl
import struct

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
return socket.inet_ntoa(fcntl.ioctl(s.fileno(), 0x8915, struct.pack('256s', ifname[:15]))[20:24])

$function$
