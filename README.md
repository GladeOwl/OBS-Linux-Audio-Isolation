# OBS Linux Audio Isolation using Pipewire

# The What
A simple bash script that isolates OBS Audio channels to individual apps. It automatically links OBS Audio Source to the app we set and also delinks it from the default audio source of the device.

# The How
### Prerequisites
- OBS, installed and ready with a scene for your game or app.

#### Done. Now what?
1.  Within OBS, create a new Audio Source using "Audio Output Capture (PulseAudio)". 
    - Whatever you name it. Add it to the **OBS_APP_NODE_NAME** variable within the script.
    - You can leave the Device as Default.

2. Find the Desktop Audio Node. 
```sh
# run the command
pw-link -ol
```
> It will output a list. You're looking for something consisting of "stereo" near the top of the list.
```
# example
alsa_output.pci-0000_2d_00.4.analog-stereo:monitor_FL
|-> OBS:input_FL

# you only need
alsa_output.pci-0000_2d_00.4.analog-stereo
```
> This is your **Desktop Audio Node** name. Add this to the **DESKTOP_NODE_NAME** variable within the script.

3.  To find **APP_NODE_NAME**, run the ``pw-link -ol`` command again while the app in question is running. You should see it somewhere in the list. With a similar format as the Desktop Node, Add it to the **APP_NODE_NAME** variable within the script.

```
example
Arma 3:output_FL
|-> alsa_output.pci-0000_2d_00.4.analog-stereo:playback_FL

# you only need
Arma 3
```

4. Make the script an executable.
```sh
chmod +x ./obs-isolate.sh
```

5. Run it. Make sure both OBS and the App you're capturing audio from are running.
```sh
./obs-isolate.sh
```

> This script should be run everytime you (re)launch OBS and/or the App(s) you're isolating.

# The Why
Because Pipewire and OBS-Linux make things unnecessarily hard.

