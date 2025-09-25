# Genesis Tool

Genesis Tool is a powerful, menu-driven Bash script designed to automate the entire lifecycle of a new Ubuntu server. It transforms the tedious, error-prone process of server setup into a fast, secure, and consistent workflow, accessible from a single, user-friendly command-line interface.

This tool is perfect for developers, students, and junior system administrators who need to provision servers quickly without missing critical setup and security steps.

---

## Features

* **💻 Automated Initialization:** Updates the system, installs essential packages (`git`, `curl`, etc.), and creates a new `sudo`-privileged user with your SSH key.
* **🛡️ One-Click Security Hardening:** Configures the UFW firewall, disables root SSH login, and installs Fail2Ban to protect against brute-force attacks.
* **🩺 Real-Time Monitoring:** Launches a persistent `tmux` session with `btop`, providing a beautiful and comprehensive real-time dashboard of system resources.
* **🐳 Docker & Application Deployment:** Installs Docker and Docker Compose, then deploys a containerized NGINX web server with a single menu option.
* ** modular Codebase:** Organized with a clean, multi-file structure to demonstrate professional coding practices.

---

## Getting Started

Follow these steps to use the Genesis Tool on a new Ubuntu 22.04 server.

### Prerequisites

* A fresh Ubuntu 22.04 server.
* Access to the server as the `root` user via SSH with a key.

### Installation & Execution

1.  **Log in to your server as `root`:**
    ```bash
    ssh root@<YOUR_SERVER_IP>
    ```

2.  **Clone the repository:**
    ```bash
    git clone [https://github.com/](https://github.com/)<YOUR_USERNAME>/genesis-tool.git
    ```

3.  **Navigate into the directory and make the script executable:**
    ```bash
    cd genesis-tool
    chmod +x genesis.sh
    ```

4.  **Run the tool:**
    ```bash
    ./genesis.sh
    ```
    This will launch the interactive menu, and you can begin provisioning your server.

---

## Usage

Once the script is running, you will be presented with a menu. Simply type the number corresponding to the task you want to perform.

1.  **Initialize Server:** **Run this first.** It will prepare your server and create your new user account. You will be prompted to log out of `root` and log back in as your new user.
2.  **Harden Security:** Run this after logging in as your new user to apply firewall rules and lock down SSH.
3.  **Show Health Monitor (btop):** Launches or attaches to a `btop` monitoring session running inside `tmux`.
4.  **Install Docker & Deploy NGINX:** Automates the installation of Docker and launches a sample NGINX web server.

