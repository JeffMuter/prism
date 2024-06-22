//go:build windows

package operating_system

import (
	"os"

	"golang.org/x/sys/windows"
)

// GetTerminalSize retrieves the console size on Windows
func GetTerminalSize() (int, int, error) {
	h := windows.Handle(os.Stdout.Fd())
	var info windows.ConsoleScreenBufferInfo
	err := windows.GetConsoleScreenBufferInfo(h, &info)
	if err != nil {
		return 0, 0, err
	}
	width := int(info.Window.Right - info.Window.Left + 1)
	height := int(info.Window.Bottom - info.Window.Top + 1)
	return width, height, nil
}
