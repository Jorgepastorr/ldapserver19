#!/usr/bin/python
import pam

p=pam.pam()
userName=raw_input("Nom usuari: ")
userPasswd=raw_input("Passwd: ")

p.authenticate(userName, userPasswd)
print('{} {}'.format(p.code,p.reason))

if p.code == 0:
    for i in range(1,11):
        print i,
else:
    print "Error autenticacio"