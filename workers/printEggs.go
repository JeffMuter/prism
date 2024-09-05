package workers

import (
	"fmt"
	"prism/util"
)

type PrintableEggFactory interface {
	CreatePrintable(egg Egg) util.Printable
}

type eggState struct{ Egg }
type EggStateFactory struct{}

func (factory EggStateFactory) CreatePrintable(egg Egg) util.Printable {
	return eggState{egg}
}
func (egg eggState) StringToPrint() string {
	return fmt.Sprintf("%s | %d |", "egg: ", egg.LocationId)
}

func eggStateFactory(worker Worker) util.Printable {
	return workerState{Worker: worker}
}

func MakeEggsPrintable(eggs []Egg, factory PrintableEggFactory) []util.Printable {
	var prints []util.Printable
	for _, worker := range eggs {
		print := factory.CreatePrintable(worker)
		prints = append(prints, print)
	}
	return prints
}
