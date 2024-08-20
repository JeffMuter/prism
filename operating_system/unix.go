//go:build linux || darwin

package operating_system

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"

	"golang.org/x/sys/unix"
)

type Wifi struct {
	MacAddress string
}

// GetTerminalSize retrieves the terminal size on Unix-like systems
func GetTerminalSize() (int, int, error) {
	ws, err := unix.IoctlGetWinsize(int(os.Stdout.Fd()), unix.TIOCGWINSZ)
	if err != nil {
		return 140, 20, nil
	}
	return int(ws.Col), int(ws.Row), nil
}

func GetWifiInfo() (string, error) {
	if isWSL() {
		cmd := exec.Command("powershell.exe", "-Command", "Get-NetAdapter -Name '*Wi-Fi*' | Select-Object -ExpandProperty MacAddress")
		stdout, err := cmd.Output()
		if err != nil {
			return "", fmt.Errorf("error getting Wi-Fi info in WSL: %v", err)
		}
		return strings.TrimSpace(string(stdout)), nil
	} else {
		cmd := exec.Command("nmcli", "-t", "-f", "ACTIVE,BSSID", "dev", "wifi")
		stdout, err := cmd.Output()
		if err != nil {
			return "", fmt.Errorf("error getting Linux wifi info: %v", err)
		}

		scanner := bufio.NewScanner(strings.NewReader(string(stdout)))
		for scanner.Scan() {
			line := scanner.Text()
			parts := strings.Split(line, ":")
			if len(parts) > 1 && parts[0] == "yes" {
				bssid := strings.Join(parts[1:], ":")
				bssid = strings.ReplaceAll(bssid, "\\", "")
				return bssid, nil
			}
		}
	}

	return "", fmt.Errorf("no active WiFi connection found")
}
func isWSL() bool {
	f, err := os.Open("/proc/version")
	if err != nil {
		return false
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		if strings.Contains(scanner.Text(), "Microsoft") {
			return true
		}
	}
	return false
}
