package menus

import (
	"fmt"
	"prism/user"
	"prism/util"
	"prism/workers"
)

func EggMenuOptions(user user.User) error {
	// user wants to see all eggs here.
	eggs, err := workers.GetEggsAvailableForUser(user.Id)
	if err != nil {
		return fmt.Errorf("issue getting eggs available for user: %v\n", err)
	}

	if len(eggs) == 0 {
		return fmt.Errorf("no existing eggs to be found")
	}

	printables := workers.MakeEggsPrintable(eggs, workers.EggStateFactory{})
	chosenEggIndex, err := util.PrintNumericSelection(printables)
	if err != nil {
		return fmt.Errorf("error getting the index from printable eggs: %w,", err)
	}
	chosenEgg := eggs[chosenEggIndex]

	// if hatch is the first word in the command, and an int is the rest,
	// we know they're trying to hatch the egg of that index of eggs
	err = workers.HatchEgg(chosenEgg.Id)
	if err != nil {
		return fmt.Errorf("error in hatching egg: %v\n", err)
	}
	return nil
}
