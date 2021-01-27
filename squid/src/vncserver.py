#!/usr/bin/env python

import pexpect

child=pexpect.spawn("vncserver")
print(child.readline())
print(child.readline())
print(child.readline())
child.sendline("1234567")                            #Password:
print(child.readline())
child.sendline("1234567")                            #Verify:
print(child.readline())
child.sendline("n")
print(child.readline())

