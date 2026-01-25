## ⚠️ Important: Known VS Code Bug

If there are errors in the Problems panel, when starting a debug session with a preLaunchTask (such as RemoteDebugSetup), you will see the message:

   Errors exist after running preLaunchTask 'RemoteDebugSetup'.

Even if the task completed successfully, VS Code will show this warning and may prevent debugging from starting. However, you can continue by clicking the 'Debug Anyway' button in the notification.

In this project configuration, you will not see this warning by default, because the required setting is already present:

    "debug.onTaskErrors": "debugAnyway"
in `.vscode/settings.json`. This allows debugging to continue automatically even if there are errors in the Problems panel.



This bug has not been fixed for over 3 years, despite being acknowledged by the VS Code team. More details: https://dev.to/codepo8/running-a-dedicated-local-server-for-a-vs-code-debugging-session-using-tasks-25ck

# Baremetal VS Code Project Template

This repository is a template for baremetal embedded projects, optimized for development and debugging in Visual Studio Code.

## Features
- Pre-configured `launch.json` for Cortex-Debug (J-Link, SWD, FreeRTOS, RTT, SVD, etc.)
- Centralized firmware, SVD, device, J-Link serial, and remote host configuration via `settings.json`
- CMake build integration
- Ready for remote and local debugging
- Automated remote debug setup via SSH and JLinkRemoteServer
- Minimal user input required (only IP address and, optionally, SSH password)

## Getting Started

1. **Clone this repository**
   ```sh
   git clone <your-new-repo-url>
   ```
2. **Configure your project**
    - Edit `.vscode/settings.json` to set:
       - `bm.firmwareFileName` — your firmware ELF file name
       - `bm.svdFileName` — your SVD file name
       - `bm.deviceName` — your MCU device name (used for both debug and J-Link server)
       - `bm.jlinkSerial` — your J-Link serial number (for remote debug)
       - `bm.remoteHostName` — SSH user name for remote debug server
       - `bm.remoteHost` — SSH host/IP for remote debug server
    - Optionally, adjust CMake and source files for your project.

3. **Build**
   - Use the VS Code build task (`CMake: build`) or run CMake manually.

4. **Debug**
   - Select a debug configuration (remote/local, attach/launch) in VS Code.
   - For remote debug, select "Launch Remote jlink with setup". The setup script will:
     - Stop any previous JLinkGDBServer on the remote host
     - Start JLinkRemoteServer with parameters from settings.json
     - Optionally, prompt for SSH password (if not using SSH keys)
   - Enter the target IP address and SSH password if prompted.

## Folder Structure
- `.vscode/launch.json` — Debugger and launch configurations
- `.vscode/settings.json` — Centralized project variables (firmware, device, serial, remote host)
- `.vscode/remote_debug_start.sh` — Script for remote debug server setup via SSH
- `build/` — Output directory for firmware binaries
- `CMakeLists.txt` — CMake build script (add your sources)

## Requirements
- [Visual Studio Code](https://code.visualstudio.com/)
- [Cortex-Debug extension](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)
- [CMake Tools extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- J-Link tools and drivers (with JLinkRemoteServer on remote host)
- arm-none-eabi-gcc toolchain
- [sshpass](https://linux.die.net/man/1/sshpass) (optional, for password automation)

## Remote Debug Setup Details

- The script `.vscode/remote_debug_start.sh` is called automatically before remote debug.
- It stops any previous JLinkGDBServer on the remote host and starts JLinkRemoteServer with parameters from settings.json.
- All required parameters (device, serial, host) are passed as environment variables from VS Code tasks.
- If SSH password is required, it is prompted via VS Code input and passed securely to the script.
- For best experience, set up SSH keys for passwordless login, or use the password prompt.

## Customization
- Add or modify debug configurations in `.vscode/launch.json` as needed.
- Add your source files and update `CMakeLists.txt`.

## License
MIT or your preferred license.

---
This template is designed to help you quickly bootstrap new baremetal embedded projects with a consistent and convenient VS Code setup, including robust remote debugging support.
