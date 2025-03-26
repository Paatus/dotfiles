#!/usr/bin/env python3
# Original Author: Elkowar https://github.com/elkowar/dots-of-war/blob/master/eww-bar/.config/eww-bar/swayspaces.py

import subprocess
import json
import threading


def get_monitors():
    bs = subprocess.check_output("bspc query --monitors --names".split(" "))
    output = bs.decode("utf-8").strip().split("\n")
    return output

def get_monitor_desktops(monitor_name):
    bs = subprocess.check_output(f"bspc query --desktops --monitor {monitor_name}".split(" "))
    output = bs.decode("utf-8").strip().split("\n")
    return output

def get_focused_desktop():
    bs = subprocess.check_output("bspc query --desktops --desktop focused".split(" "))
    output = bs.decode("utf-8").strip().split("\n")[0]
    return output

def is_occupied(desktop_id):
    print(desktop_id)
    try:
        bs = subprocess.check_output(f"bspc query --nodes --desktop {desktop_id}".split(" "))
    except subprocess.CalledProcessError:
        return False
    output = len(bs.decode("utf-8").strip().split("\n")) > 0
    return output

def generate_workspace_data(focused_desktop_id = None) -> dict:
    data = {}
    print(focused_desktop_id)
    for monitor in get_monitors():
        monitor_desktops = [{ "id": desktop_id, "focused": desktop_id == focused_desktop_id, "occupied": is_occupied(desktop_id) } for desktop_id in get_monitor_desktops(monitor)]

        data[monitor] = json.dumps(monitor_desktops)
    return data

def output_reader(proc):
    for line in iter(proc.stdout.readline, b''):
        print(json.dumps(generate_workspace_data(get_focused_desktop())), flush=True)


if __name__ == "__main__":
    process = subprocess.Popen(
        "bspc subscribe desktop_focus node_add node_remove node_transfer".split(" "),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )


    print(json.dumps(generate_workspace_data(get_focused_desktop())), flush=True)
    t = threading.Thread(target=output_reader, args=(process,))
    t.start()
    if process.stdout is None:
        print("Error: could not subscribe to sway events")
        exit(1)
    # while True:
    #     print(json.dumps(generate_workspace_data()), flush=True)
    #     line = process.stdout.readline().decode("utf-8")
    #     if line == "":
    #         break
