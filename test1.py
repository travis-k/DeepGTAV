#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from deepgtav.messages import Start, Stop, Scenario, Commands, frame2numpy
from deepgtav.client import Client

import json
import socket, struct
import time

if __name__ == '__main__':

    ip = 'localhost'
    port = 8000

    # Connecting
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((ip, int(port)))

    # Creating the "start" settings, which we send to the game to begin
    message = Start(scenario=Scenario(drivingMode=-1))
    
    jsonstr = message.to_json().encode('utf-8')
    print(len(jsonstr).to_bytes(4, byteorder='little'))
    print(jsonstr)
    s.sendall(len(jsonstr).to_bytes(4, byteorder='little'))
    s.sendall(jsonstr)

    # Creating and sending the "stop" message
    message = Stop()
    jsonstr = message.to_json().encode('utf-8')
    print(len(jsonstr).to_bytes(4, byteorder='little'))
    print(jsonstr)
    s.sendall(len(jsonstr).to_bytes(4, byteorder='little'))
    s.sendall(jsonstr)

    s.close()
