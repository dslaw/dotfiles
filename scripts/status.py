#!/usr/bin/env python3

from datetime import datetime
from subprocess import check_output
import re


def vpn():
    vpn_running = False
    vpn_server = None
    pattern = r"/etc/openvpn/(.+).ovpn"

    lines = check_output(["ps", "-aux"]).decode().split("\n")
    for line in lines:
        if "openvpn" in line:
            vpn_running = True
            match = re.search(pattern, line)
            if match:
                vpn_server = match.group(1)
                break

    return vpn_running, vpn_server


def connection():
    lines = check_output(["wicd-cli", "--status"]).decode().split("\n")

    # If not connected, there will only be one line.
    # If connection is in progress, there will be two lines.
    # If connected, four lines.
    status, *_ = lines
    if status.endswith("Not connected"):
        connected = False
        connection_info = None
        wireless = None

    elif status.endswith("Connection in progress"):
        _, connection_info, *_ = lines
        connected = False
        wireless = "wireless" in connection_info

    elif status.endswith("Connected"):
        _, type_, connection_info, *_ = lines
        connected = True
        wireless = "Wireless" in type_
        connection_info = re.sub(r"\(.+\)$", "", connection_info).strip()

    else:
        raise RuntimeError

    return connected, wireless, connection_info


def date_time():
    current = datetime.now()
    date_string = current.strftime("%Y-%m-%d")
    time_string = current.strftime("%a %H:%M")
    return date_string, time_string


def read_uevent(filename):
    data = {}
    with open(filename) as fh:
        for line in fh:
            name, value = line.strip().split("=")
            data[name] = value
    return data


def battery(name):
    uevent = read_uevent(f"/sys/class/power_supply/{name}/uevent")
    max_capacity = int(uevent["POWER_SUPPLY_ENERGY_FULL"])
    current = int(uevent["POWER_SUPPLY_ENERGY_NOW"])
    return current / max_capacity


def plugged_in():
    uevent = read_uevent(f"/sys/class/power_supply/AC/uevent")
    return int(uevent["POWER_SUPPLY_ONLINE"]) == 1


color_good = "#919652"
color_neutral = "white"
color_degraded = "#E2995C"
color_alert = "#B04C50"
template = (
    '<span foreground="{fg_color}">{icon}</span> '
    '<span foreground="white">{text}</span>'
)
output_lines = []


date_string, time_string = date_time()
output_lines.append(
    template.format(
        fg_color=color_neutral,
        icon="",
        text=f"{date_string}, {time_string}",
    )
)


connected, wireless, conn_info = connection()
connection_icon = {
    None: "",
    False: "",
    True: "",
}[wireless]
output_lines.append(
    template.format(
        fg_color=color_good if connected else color_alert,
        icon=connection_icon,
        text=conn_info or "",
    )
)


vpn_running, vpn_server = vpn()
output_lines.append(
    template.format(
        fg_color=color_good if vpn_running else color_alert,
        icon="",
        text=vpn_server or "",
    )
)


plugged = plugged_in()
battery_proportion = battery("BAT0")

if plugged:
    power_color = color_neutral
    power_icon = ""
else:
    if battery_proportion > .75:
        power_color = color_good
        power_icon = ""
    elif battery_proportion > .5:
        power_color = color_good
        power_icon = ""
    elif battery_proportion > .25:
        power_color = color_alert
        power_icon = ""
    elif battery_proportion > .1:
        power_color = color_alert
        power_icon = ""
    else:
        power_color = color_degraded
        power_icon = ""


output_lines.append(
    template.format(
        fg_color=power_color,
        icon=power_icon,
        text=f"{battery_proportion:.2%}",
    )
)

print("\n".join(output_lines))
