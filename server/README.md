# BoomPow Server

## Setup

### Requirements

1. Python 3.6.7 or higher.
2. A redis server running on `redis://localhost` by default.
3. An MQTT broker (tested with Mosquitto) with listeners on port `1883` and `8883`.
3.a A websocket listener on port `9001` to enable dashboard / monitoring services.
4. Authentication configured on the MQTT broker
5. Callbacks from a BANANO node to `127.0.0.1:5030` by default.
6. DNS configured and web server running (configuration example is Nginx).

### Installation

```bash
cd /path/to/boompow/server
virtualenv -p python3.6 venv
source venv/bin/activate
pip3 install -r requirements.txt
```

- Ensure password configuration is correct for MQTT: `sudo mosquitto_passwd -c /etc/mosquitto/passwd {MQTT_USER}`
  - Ensure `client` & `bpowinterface` user added to `/etc/mosquitto/passwd`
- Update mosquitto configuration to enforce passwords and set up listeners: `sudo cp example.conf /etc/mosquitto/conf.d/default.conf`
- Update service with correct paths and copy to systemd: `sudo cp example.conf /etc/systemd/system/boompow.service | sudo vim /etc/systemd/system/boompow.service`
- Open port 8883: `sudo ufw allow 8883`
- Update web config with correct DNS and copy to nginx config: `sudo cp examplewebservice /etc/nginx/sites-available/boompowserver | sudo vim /etc/nginx/sites-available/boompowserver`
- OPTIONAL: secure website using certbot here - find more info at https://letsencrypt.org/getting-started/
- Link and enable the site: `ln -s /etc/nginx/sites-available/boompowserver /etc/nginx/sites-enabled/`
- Test nginx to ensure everything is correct: `sudo nginx -t`
- Reload nginx: `sudo service nginx reload`
- Set up ACLs: `sudo cp exampleacl.conf /etc/mosquitto/acls.conf`
- Add `acl_file /etc/mosquitto/acls.conf` to the bottom of the mosquitto config: `sudo vim /etc/mosquitto/mosquitto.conf`
- Create client and bpowinterface users: `sudo mosquitto_passwd -c /etc/mosquitto/passwd client` `sudo mosquitto_passwd -c /etc/mosquitto/passwd bpowinterface`
- Reload mosquitto and start service: `sudo systemctl restart mosquitto | sudo systemctl start boompow`

## Running

```bash
python3 bpow_server.py
```
