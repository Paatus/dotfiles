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

def generate_workspace_data(focused_desktop_id = None) -> dict:
    data = {}
    for monitor in get_monitors():
        monitor_desktops = [{ "id": desktop_id, "focused": desktop_id == focused_desktop_id } for desktop_id in get_monitor_desktops(monitor)]
        # for desktop_id in get_monitor_desktops(monitor):
        #     print(focused_desktop_id, desktop_id)
        #     monitor_desktops[desktop_id] = { "id": desktop_id, "focused": desktop_id == focused_desktop_id }

        data[monitor] = json.dumps(monitor_desktops)
        # if wsp["output"] not in data:
        #     data[wsp["output"]] = []
        # i = { "name": wsp["name"],
        #       "monitor": wsp["output"],
        #       "focused": wsp["focused"],
        #       "visible": wsp["visible"],
        #     }
        # if wsp["focused"]:
        #     i["class"] = "focused"
        #     i["icon"] = ""
        # elif wsp["visible"]:
        #     i["class"] = "visible"
        #     i["icon"] = ""
        # else:
        #     i["class"] = "hidden"
        #     i["icon"] = ""
        # data[wsp["output"]].append(i)
    return data

def output_reader(proc):
    for line in iter(proc.stdout.readline, b''):
        msg = line.decode('utf-8')
        parts = [s.strip() for s in msg.split(" ")]
        print('got line: {0}'.format(msg), end='')
        if  msg.split(" ")[0] == "desktop_focus":
            print(json.dumps(generate_workspace_data(parts[2])), flush=True)


if __name__ == "__main__":
    process = subprocess.Popen(
        "bspc subscribe desktop_focus node_add node_remove".split(" "),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )

    print(json.dumps(generate_workspace_data()), flush=True)
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
