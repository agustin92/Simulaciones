#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 17 11:49:17 2019

@author: agustin
"""

import subprocess

completed = subprocess.run('pwd',
    stdout=subprocess.PIPE,
)
print('returncode:', completed.returncode)
#print('salida stdout: {}'.format(completed.stdout))
print(completed.stdout.decode('utf-8'))