# BoomPow Client

These steps will guide you on how to setup a new work client. The nano-work-server provided is based on [nanocurrency/nano-work-server](https://github.com/nanocurrency/nano-work-server). Only this work server is fully supported.

## Setup

### Requirements

1. [Python](https://www.python.org/) 3.6.7 or higher.
  **Python 3.10.x is not yet supported.**

### Installation

- Download the [latest version](https://github.com/bbedward/boompow/releases) and extract it.
- On Linux, open a terminal and cd to the bpow-client directory.
- On Windows, shift + right-click in the bpow-client directory and click  "Open Powershell window here".
- On MacOS, in Finder right click on the bpow-client directory and click "New Terminal at bpow-client"
- `pip3 install --user -r requirements.txt`

## Running

You need to find out what your GPU vendor/device numbers are if you're going to be using a GPU. Usually it will be either `0:0`, `0:1`, or `1:0`, depending on how many you have (including integrated graphics).

### Linux

1. Install required library
  ```bash
  sudo apt install ocl-icd-libopencl1
  ```
2. Check `./bin/linux/nano-work-server --help` for information on how to select your GPU (or CPU).
3. Run the work server:
  ```bash
  ./bin/linux/nano-work-server --gpu 0:0 -l 127.0.0.1:7000
  ```
4. Check the client configuration options with `python3 bpow_client.py --help`
5. Run the client:
  ```bash
  python3 bpow_client.py --payout YOUR_BANANO_ADDRESS --work {ondemand,precache,any}
  ```

### Windows

1. Edit the file `run_windows.bat` with your desired configuration (including the work-server GPU config).
2. Double-click the same file, which should eventually open two terminals. You must leave them running in the foreground. You can minimize but not close them (sorry!).

### MacOS

1. Check `./bin/macos/nano-work-server --help` for information on how to select your GPU (or CPU).
2. Run the work server:
   ```bash
   ./bin/macos/nano-work-server --gpu 0:0 -l 127.0.0.1:7000
   ```
3. Press ⌘+T to open a new tab
4. Run the client:
   ```bash
   python3 bpow_client.py --payout YOUR_BANANO_ADDRESS --work {ondemand,precache,any}
   ```
