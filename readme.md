# Alpine

Script for headless setup for Alpine Linux on a Raspberry Pi 4.
The headless part follows instructions by: https://github.com/macmpi/alpine-linux-headless-bootstrap

## How to

1. Connect sd card
2. Create a `wpa_supplicant.conf` file (example: `wpa_supplicant_sample.conf`)
3. Run `sudo ./prepare.sh` to setup sd and to transfer files
4. Plug sd card into Rasperry Pi
5. Start the Pi
6. Connect to the pi over ssh as `root` user
