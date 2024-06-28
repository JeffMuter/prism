package wifi

import (
	"bufio"
	"fmt"
	"os/exec"
	"strings"
)

type Wifi struct {
	MacAddress string
}

func GetWifiInfoWindows() (string, error) {
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
