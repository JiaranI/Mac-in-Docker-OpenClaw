# Mac-in-Docker-OpenClaw

> **No Mac? No Problem!**
>
> Want to experience OpenClaw's full capabilities but don't have a Mac? This project lets you run macOS via Docker on Windows / Linux, unlocking all OpenClaw features at zero cost.
>
> Already have a Mac but worried about security? Run it in Docker for safe, isolated experimentation.

## Table of Contents

- [Prerequisites](#prerequisites)
- [When to Use This Setup](#when-to-use-this-setup)
- [What You Get](#what-you-get)
- [Requirements](#requirements)
- [Download macOS Image](#download-macos-image)
- [Start macOS Docker Container](#start-macos-docker-container)
- [Connect to macOS](#connect-to-macos)
- [OpenClaw App Guide](#openclaw-app-guide)
- [Demo](#demo)

---

## Prerequisites

- Docker installed
- Linux or Windows (WSL)

---

## When to Use This Setup

- You want to run macOS on Linux or Windows
- You need macOS-only features (for example, iMessage via BlueBubbles)
- You want a containerized, reproducible macOS environment

## What You Get

- macOS running on Linux/Windows without Apple hardware
- iMessage support via BlueBubbles (after setup)
- Portable environment that is easy to reset

## Requirements

### Linux

- Modern CPU with virtualization support (Intel VT-x or AMD-V)
- KVM enabled (`/dev/kvm` accessible)
- Docker installed
- ~80 GB free disk space
- 8+ GB RAM recommended

### Windows

- Windows 10/11 with WSL2
- Docker Desktop with WSL2 backend
- ~80 GB free disk space
- 8+ GB RAM recommended

---

## Download macOS Image


Download the required image files (~40GB) from Hugging Face:

```bash
pip install huggingface_hub

huggingface-cli download fuyikun/Mac-in-docker-OpenClaw --local-dir .
```

Or using Python:

```python
from huggingface_hub import snapshot_download

snapshot_download(repo_id="fuyikun/Mac-in-docker-OpenClaw", local_dir=".")
```

---

## Start macOS Docker Container

**For Linux users:**

```bash
# Start the container
sudo docker run -itd \
    --name "macos_openclaw" \
    --device /dev/kvm \
    -p 52272:10022 \
    -p 5902:5902 \
    --add-host=host.docker.internal:host-gateway \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -e EXTRA="-vnc 0.0.0.0:2,password=off" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e CPU='Haswell-noTSX' \
    -e CPUID_FLAGS='kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on' \
    -v "/path/to/mac_hdd_ng.img:/home/arch/OSX-KVM/mac_hdd_ng_src.img" \
    -v "/path/to/BaseSystem.img:/home/arch/OSX-KVM/BaseSystem_src.img" \
    -e SHORTNAME=tahoe \
    -e USERNAME=test \
    -e PASSWORD='1234' \
    numbmelon/docker-osx-evalkit-auto:latest
```

**For Windows (WSL2) users:**

Run the same command inside your WSL2 Linux distribution. The `/dev/kvm` device and X11 socket paths are Linux-specific, so make sure KVM is available in WSL2.

Replace `/path/to/` with the actual path where you downloaded the image files.

---

## Connect to macOS

### SSH connection

```bash
ssh -p 52272 test@localhost
```

### VNC connection (desktop)

```bash
vncviewer localhost:5902
```

Enter 1234 as password to unlock the desktop.

![macOS Desktop](images/macos.png)

> **Note**: The first connection may take a while as the container fully boots up.

Then download OpenClaw.img and continue to the [OpenClaw App Guide](https://docs.openclaw.ai/start/onboarding) to configure the macOS app.

---



## OpenClaw App Guide



First, download the OpenClaw macOS app. Then follow the official onboarding guide for setup and channel configuration:

- [OpenClaw App Guide](https://docs.openclaw.ai/start/onboarding)

---

## Demo
![Final Demo](images/final.png)


### Check Environment

```
Report the environment you are currently in
```

![Environment Report](images/report_state.png)

You can see OpenClaw is running in macOS environment.

### Send WhatsApp Message

```
send a message to my whatsapp
```

![WhatsApp Message](images/whatsapp.jpg)

### Set Reminders

```
Use Reminders to set a reminder for 8:00 AM tomorrow morning.
```

![Reminders](images/reminders.jpg)

Example reminder formats:

| Command | Description |
|---------|-------------|
| `Remind me to call mom at 3pm` | Reminder at 3 PM |
| `Set a reminder for tomorrow 9am to check emails` | Tomorrow 9 AM reminder |
| `Create a reminder: meeting in 2 hours` | Reminder in 2 hours |

---


## Acknowledgements

Thanks to [sickcodes/Docker-OSX](https://github.com/sickcodes/Docker-OSX) and [OpenGVLab/ScaleCUA](https://github.com/OpenGVLab/ScaleCUA).

---

*Last updated: 2026-02-13*
