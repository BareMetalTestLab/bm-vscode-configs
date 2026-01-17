# Baremetal VS Code Project Template

This repository is a template for baremetal embedded projects, optimized for development and debugging in Visual Studio Code.

## Features
- Pre-configured `launch.json` for Cortex-Debug (J-Link, SWD, FreeRTOS, RTT, SVD, etc.)
- Centralized firmware, SVD, and device configuration via `settings.json`
- CMake build integration
- Ready for remote and local debugging
- Minimal user input required (only IP address for remote debug)

## Getting Started

1. **Clone this repository**
   ```sh
   git clone <your-new-repo-url>
   ```
2. **Configure your project**
   - Edit `.vscode/settings.json` to set:
     - `bm.firmwareFileName` — your firmware ELF file name
     - `bm.svdFileName` — your SVD file name
     - `bm.deviceName` — your MCU device name
   - Optionally, adjust CMake and source files for your project.

3. **Build**
   - Use the VS Code build task (`CMake: build`) or run CMake manually.

4. **Debug**
   - Select a debug configuration (remote/local, attach/launch) in VS Code.
   - Enter the target IP address if prompted (for remote debug).

## Folder Structure
- `.vscode/launch.json` — Debugger and launch configurations
- `.vscode/settings.json` — Centralized project variables
- `build/` — Output directory for firmware binaries
- `CMakeLists.txt` — CMake build script (add your sources)

## Requirements
- [Visual Studio Code](https://code.visualstudio.com/)
- [Cortex-Debug extension](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)
- [CMake Tools extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- J-Link tools and drivers
- arm-none-eabi-gcc toolchain

## Customization
- Add or modify debug configurations in `.vscode/launch.json` as needed.
- Add your source files and update `CMakeLists.txt`.

## License
MIT or your preferred license.

---
This template is designed to help you quickly bootstrap new baremetal embedded projects with a consistent and convenient VS Code setup.
