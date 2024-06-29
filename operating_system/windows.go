//go:build windows || darwin

package operating_system

import (
	"bufio"
	"fmt"
	"golang.org/x/sys/windows"
	"os"
	"os/exec"
	"strings"
)

type Wifi struct {
	MacAddress string
}

// GetTerminalSize retrieves the console size on Windows
func GetTerminalSize() (int, int, error) {
	h := windows.Handle(os.Stdout.Fd())
	var info windows.ConsoleScreenBufferInfo
	err := windows.GetConsoleScreenBufferInfo(h, &info)
	if err == nil {
		width := int(info.Window.Right - info.Window.Left + 1)
		height := int(info.Window.Bottom - info.Window.Top + 1)
		return width, height, nil
	} else {
		return 140, 20, nil
	}
}
func GetWifiInfo() (string, error) {
	cmd := exec.Command("netsh", "wlan", "show", "interfaces")
	stdout, err := cmd.Output()
	if err != nil {
		fmt.Println("command to windows error: ", err)
	}

	scanner := bufio.NewScanner(strings.NewReader(string(stdout)))
	for scanner.Scan() {
		line := scanner.Text()
		if strings.Contains(line, "BSSID") {
			return strings.TrimSpace(strings.SplitN(line, ":", 2)[1]), nil
		}
	}

	return "", fmt.Errorf("no windows Wifi info found")
}
