import random
import time
import json
from paho.mqtt import client as mqtt_client


broker = "broker.hivemq.com"
#broker = "broker.emqx.io"
port = 1883
topic = "/control_device"
# generate client ID with pub prefix randomly
client_id = f'python-mqtt-{random.randint(0, 1000)}'
# username = 'emqx'
# password = '**********'


def connect_mqtt():
    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker!")
        else:
            print("Failed to connect, return code %d\n", rc)

    client = mqtt_client.Client(client_id)
    # client.tls_set(ca_certs='./server-ca.crt')
    # client.username_pw_set(username, password)
    client.on_connect = on_connect
    client.connect(broker, port)
    return client


def publish(client, topic=topic, msg=json.dumps({"name": "Geats"})):
    result = client.publish(topic, msg)
    # result: [0, 1]
    status = result[0]
    if status == 0:
        print(f"Send `{msg}` to topic `{topic}`")
    else:
        print(f"Failed to send message to topic {topic}")


def run():
    client = connect_mqtt()
    client.loop_start()
    while (1):
        print("Input kamen rider name:")
        name = input()
        publish(client, msg=json.dumps({"name": name}))


if __name__ == '__main__':
    run()
