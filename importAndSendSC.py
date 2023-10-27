"""Small example OSC client

This program sends 10 random values between 0.0 and 1.0 to the /filter address,
waiting for 1 seconds between each value.
"""
import argparse
import random
import time

from pythonosc import osc_message_builder
from pythonosc import udp_client


import socket


# Set the IP address and port to listen on
ip_address = "172.27.160.56" # Listen on all available network interfaces
port = 12345 # Use the same port number as the one in your ESP32 code


# Create a UDP socket
udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)


# Bind the socket to the IP address and port
udp_socket.bind((ip_address, port))


print(f"Listening for UDP packets on {ip_address}:{port}")


client = udp_client.SimpleUDPClient("172.27.160.56", 57120) 

# for x in range(10) :
#     number = random.random()
#     client.send_message(str(number), [number, "I can also send strings"])
#     print("hello world")
#     print("stupid")
#     time.sleep(0.1)

while True:
# Receive data and the sender's address
    data, address = udp_socket.recvfrom(1024) # Adjust the buffer size as needed
    print(f"Received data from {address}: {data.decode('utf-8')}") # Decode the data to a string
    number = random.random()
    new = data.decode('utf-8')
    client.send_message(str(new), [number, "I can also send strings"])

