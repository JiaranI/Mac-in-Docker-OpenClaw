# Mac-in-Docker-OpenClaw

> **No Mac? No Problem!**
>
> Want to experience OpenClaw's full capabilities but don't have a Mac? This project lets you run macOS via Docker on Windows / Linux, unlocking all OpenClaw features at zero cost.
>
> Already have a Mac but worried about security? Run it in Docker for safe, isolated experimentation.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Download macOS Image](#download-macos-image)
- [Start macOS Docker Container](#start-macos-docker-container)
- [Configure OpenClaw](#configure-openclaw)
- [Launch OpenClaw](#launch-openclaw)
- [Demo](#demo)

---

## Prerequisites

- Docker installed
- Linux or Windows (WSL)

---

## Download macOS Image

Download the required image files from Hugging Face (~50GB):

```bash
pip install huggingface_hub

huggingface-cli download fuyikun/Mac-in-docker-OpenClaw --local-dir .
```

Or use Python:

```python
from huggingface_hub import snapshot_download

snapshot_download(repo_id="fuyikun/Mac-in-docker-OpenClaw", local_dir=".")
```

---

## Start macOS Docker Container

```bash
# Start the container
./start_mac.sh

# SSH into macOS
ssh -p 52271 pipiwu@localhost

# VNC connect to macOS desktop
vncviewer localhost:5901
```

![macOS Desktop](images/macos.jpg)

> **Note**: First connection may require waiting for the container to fully boot.

---

## Configure OpenClaw

```bash
openclaw onboard --install-daemon
```

Follow the wizard to complete the configuration:

### 1. Security Warning

Select **Yes** to continue.

### 2. Onboarding Mode

Select **QuickStart**.

### 3. Configure AI Model

1. Model/auth provider: **OpenAI**
2. OpenAI auth method: **OpenAI Codex (ChatGPT OAuth)**
3. Open the generated OAuth URL in your local browser
4. After logging in, copy the redirect URL and paste it back to the terminal

### 4. Configure WhatsApp

1. Select channel: **WhatsApp (QR link)**
2. Link WhatsApp now (QR)?: **Yes**
3. Scan the QR code in terminal with your phone
   - WhatsApp → Settings → Linked Devices → Link a Device
4. Enter your WhatsApp phone number (e.g., `+1234567890`)

### 5. Configure Skills and Services

- Configure skills now?: **Yes**
- Install missing skill dependencies: **Skip for now**
- API Keys: Configure as needed

### 6. Configure Hooks and Gateway

- Enable hooks?: **Skip for now**
- Gateway service: **Restart**

---

## Launch OpenClaw

Select **Hatch in TUI (recommended)** to start the terminal interface.

---

## Demo

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
