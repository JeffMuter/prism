package menuV2

import (
	"fmt"

	"github.com/charmbracelet/huh"
)

// TextInputConfig configures a text input prompt
type TextInputConfig struct {
	Title       string
	Prompt      string
	Placeholder string
	MaxLength   int
	Validate    func(string) error
}

// ShowTextInput displays a pretty text input form using huh
func ShowTextInput(config TextInputConfig) (string, error) {
	var value string

	// Create validation function if provided
	var validateFunc func(string) error
	if config.Validate != nil {
		validateFunc = config.Validate
	}

	// Create the form
	form := huh.NewForm(
		huh.NewGroup(
			huh.NewInput().
				Title(config.Title).
				Prompt(config.Prompt).
				Placeholder(config.Placeholder).
				Value(&value).
				Validate(validateFunc).
				CharLimit(config.MaxLength),
		),
	).WithTheme(huh.ThemeCharm())

	// Run the form
	err := form.Run()
	if err != nil {
		return "", fmt.Errorf("form error: %w", err)
	}

	return value, nil
}

// ShowConfirm displays a yes/no confirmation dialog
func ShowConfirm(title, description string) (bool, error) {
	var confirm bool

	form := huh.NewForm(
		huh.NewGroup(
			huh.NewConfirm().
				Title(title).
				Description(description).
				Value(&confirm),
		),
	).WithTheme(huh.ThemeCharm())

	err := form.Run()
	if err != nil {
		return false, fmt.Errorf("form error: %w", err)
	}

	return confirm, nil
}

// ShowSelect displays a selection menu with options
func ShowSelect(title, description string, options []string) (string, error) {
	if len(options) == 0 {
		return "", fmt.Errorf("no options provided")
	}

	var selected string

	// Convert options to huh options
	huhOptions := make([]huh.Option[string], len(options))
	for i, opt := range options {
		huhOptions[i] = huh.NewOption(opt, opt)
	}

	form := huh.NewForm(
		huh.NewGroup(
			huh.NewSelect[string]().
				Title(title).
				Description(description).
				Options(huhOptions...).
				Value(&selected),
		),
	).WithTheme(huh.ThemeCharm())

	err := form.Run()
	if err != nil {
		return "", fmt.Errorf("form error: %w", err)
	}

	return selected, nil
}


