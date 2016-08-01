#!/usr/bin/python

from ORACLE import *

def main():
    dsn = "usr_imed/076imed@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.100.100.42)(PORT=1521))(CONNECT_DATA=(SID=test)))"

    o = OracleInterface(dsn)
    print o.sp_execcall('''
	[	"ADMIMED.FNDBENCERTIF_PKG.FNDBENCERTIF",
		[	"$o$STRING", 76,"0003688091-0","29-JUL-15",
			"$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING",
			"$o$DATETIME", "$o$STRING", "$o$STRING", "$o$STRING",
			"$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING",
			"$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING",
			"$o$NUMBER", "$o$STRING[40]", "$o$STRING[40]"
		]
	]
''')

main()
