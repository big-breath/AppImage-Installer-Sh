# AppImage Installer Script

This Bash script simplifies the installation of AppImage applications on Linux systems. It allows users to easily copy an AppImage file to the appropriate directory, optionally add an icon, and create a `.desktop` entry for easy access from the application menu.

## Features

- Copy an AppImage file to the user’s local application directory.
- Optionally copy an icon to the icons directory.
- Automatically create a `.desktop` entry for the AppImage, making it accessible from the application menu.
- Only tested on Mint.

## Usage

1. **Clone this repository:**

```bash
git clone https://github.com/big-breath/AppImage-Installer-Sh.git
cd AppImage-Installer-Sh
```

2. **Make the script executable:**
```bash
chmod +x appi_install.sh
```


3. **Run the script with the required parameters:**
```bash
./appi_install.sh <AppImage path> [-i <icon path>] [-r <new name>]
```
  
