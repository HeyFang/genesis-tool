#!/bin/bash

# --- Custom health monitor function ---
health_monitor() {
    CPU_LIMIT=80
    RAM_LIMIT=80
    NETWORK_LIMIT=1000000

    TMUX_SESSION="$1"
    IFACE=$(ip route | awk '/default/ {print $5}')

    while true; do
        CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
        CPU_INT=${CPU%.*}

        RAM=$(free | awk '/Mem/ {printf "%.2f", $3/$2*100}')
        RAM_INT=${RAM%.*}

        RX1=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
        TX1=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
        sleep 1
        RX2=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
        TX2=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
        NET=$(( (RX2-RX1) + (TX2-TX1) ))

        WARNINGS=()

        (( CPU_INT > CPU_LIMIT )) && WARNINGS+=("CPU: $CPU%")
        (( RAM_INT > RAM_LIMIT )) && WARNINGS+=("RAM: $RAM%")
        (( NET > NETWORK_LIMIT )) && WARNINGS+=("NET: $NET B/s")

        if [ ${#WARNINGS[@]} -gt 0 ]; then
            # Display popup in tmux at bottom of screen
            if tmux has-session -t "$TMUX_SESSION" 2>/dev/null; then
                tmux display-message -t "$TMUX_SESSION" "#[fg=red]⚠ ${WARNINGS[*]} #[default]"
            fi
        fi

        sleep 2
    done
}

# --- Launch btop in tmux ---
show_health_monitor() {
    if ! command -v tmux &> /dev/null; then
        echo "Installing tmux..."
        sudo apt-get update && sudo apt-get install -y tmux
    fi

    if ! command -v btop &> /dev/null; then
        echo "Installing btop..."
        sudo apt-get install -y snapd
        sudo snap install btop
    fi

    local session_name="btop-monitor"

    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "✅ Found existing btop session. Attaching..."
        sleep 1
        tmux attach-session -t "$session_name"
    else
        echo "🚀 Launching btop in a new tmux session..."
        sleep 1
        tmux new-session -d -s "$session_name" btop
        # Start health monitor in background
        health_monitor "$session_name" &
        tmux attach-session -t "$session_name"
    fi
}

# --- Start everything ---
show_health_monitor

