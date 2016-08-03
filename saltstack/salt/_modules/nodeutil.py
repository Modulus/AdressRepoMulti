#!/usr/bin/python
# coding=utf-8

"""
This module will restart rabbimq docker instances in the spesified environement
"""
import salt.utils
import logging

try:
    from subprocess import Popen
    HAS_POPEN = True
except ImportError:
    HAS_POPEN = False

__virtualname__ = "nodeutil"

def __virtual__():
    log.debug("Checking if Popen is available")
    if not HAS_POPEN:
        log.debug("Popen is not available, please install this with pip install popen before trying again")
        return False
    log.debug("popen is awailable ")
    return __virtualname__



def start_server(app="", args=[], logfile="/var/log/"):
    cmd_str = 'node start /home/vagrant/nodeapp/app.js >> /var/log/nodeapp.log'
    proc = Popen([cmd_str], shell=True,
        stdin=None, stdout=None, stderr=None, close_fds=True)
    return cmd_str
