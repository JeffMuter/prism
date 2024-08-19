package menus

import (
	"fmt"
	"prism/user"
	"prism/util"
	"prism/workers"
	"strings"
)

func EggMenuOptions(user user.User) error {
	// user wants to see all eggs here.
	eggs, err := workers.GetEggsAvailableForUser(user.Id)
	if err != nil {
		return fmt.Errorf("issue getting eggs available for user: %v\n", err)
	}

	err = workers.ShowEggsDetails(eggs)
	if err != nil {
		return fmt.Errorf("issue showing eggs: %v\n", err)
	}

	//get input from user
	input, err := util.ReadCommandInput()
	if err != nil {
		return fmt.Errorf("error reading user input in egg menu: %v\n", err)
	}

	after, hadPrefix := strings.CutPrefix(input, "hatch")

	// if hatch is the first word in the command, and an int is the rest,
	// we know they're trying to hatch the egg of that index of eggs
	if hadPrefix {
		if num, ok := util.FindIntFromString(strings.TrimSpace(after)); ok == nil {
			workers.HatchEgg(eggs[num].Id)
		}
	}

	return nil
}
