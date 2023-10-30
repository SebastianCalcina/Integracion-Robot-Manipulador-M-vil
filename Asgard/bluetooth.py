import socket
import time

hc05_mac_address = '00:22:12:01:4D:43'  # Reemplaza con la dirección MAC de tu HC-05
port = 1

# Crear un socket RFCOMM
client_socket = socket.socket(socket.AF_BLUETOOTH, socket.SOCK_STREAM, socket.BTPROTO_RFCOMM)

try:
    client_socket.connect((hc05_mac_address, port))
    print("Conexión establecida con el HC-05")

    while True:
        try:
            data_to_send = "Hola desde Python"
            client_socket.send(data_to_send.encode())

            data_received = client_socket.recv(1024)
            print("Recibido:", data_received.decode())

            time.sleep(1)
        except socket.error as error:
            print("Error de comunicación:", error)
            break

    client_socket.close()

except socket.error as error:
    print("Ocurrió un error:", error)