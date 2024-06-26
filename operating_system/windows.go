package operating_system

import (
	"fmt"
	"golang.org/x/sys/windows"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

// GetTerminalSize retrieves the console size on Windows
func GetTerminalSize() (int, int, error) {
	h := windows.Handle(os.Stdout.Fd())
	var info windows.ConsoleScreenBufferInfo
	err := windows.GetConsoleScreenBufferInfo(h, &info)
	if err == nil {
		width := int(info.Window.Right - info.Window.Left + 1)
		height := int(info.Window.Bottom - info.Window.Top + 1)
		return width, height, nil
	}

	// Fallback for IDE
	cmd := exec.Command("cmd", "/c", "mode con")
	output, err := cmd.Output()
	if err != nil {
		return 0, 0, err
	}

	lines := strings.Split(string(output), "\r\n")
	var cols, rows int
	for _, line := range lines {
		if strings.Contains(line, "Columns:") {
			cols, _ = strconv.Atoi(strings.TrimSpace(strings.Split(line, ":")[1]))
		}
		if strings.Contains(line, "Lines:") {
			rows, _ = strconv.Atoi(strings.TrimSpace(strings.Split(line, ":")[1]))
		}
	}
	if cols == 0 || rows == 0 {
		return 0, 0, fmt.Errorf("unable to retrieve terminal size")
	}
	return cols, rows, nil
}
