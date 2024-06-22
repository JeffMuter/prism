//go:build linux || darwin

package operating_system

import (
	"os"

	"golang.org/x/sys/unix"
)

// GetTerminalSize retrieves the terminal size on Unix-like systems
func GetTerminalSize() (int, int, error) {
	ws, err := unix.IoctlGetWinsize(int(os.Stdout.Fd()), unix.TIOCGWINSZ)
	if err != nil {
		return 0, 0, err
	}
	return int(ws.Col), int(ws.Row), nil
}
