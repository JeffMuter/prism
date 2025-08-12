package locations

import (
	"fmt"
	"prism/util"
)

// this file contains what's needed to have printing configurations for different menus

type PrintableLocFactory interface {
	CreatePrintable(loc Location) util.Printable
}

type namePrint struct{ Location }
type NamePrintFactory struct{}

func (factory NamePrintFactory) CreatePrintable(loc Location) util.Printable {
	return namePrint{Location: loc}
}
func (loc namePrint) StringToPrint() string {
	return fmt.Sprintf("%s", loc.Name.String)
}

type someDetailsPrint struct{ Location }
type SomeDetailsPrintFactory struct{}

func (factory SomeDetailsPrintFactory) CreatePrintable(loc Location) util.Printable {
	return someDetailsPrint{Location: loc}
}

func (loc someDetailsPrint) StringToPrint() string {
	// currently no location Resources field are coming through, all set to 0
	// TODO: this instead needs to spit out this, and all resources for this location...
	return fmt.Sprintf("  %s  | %s  | Recources: %s |", loc.Name.String, loc.LocationType, createSomeDetailsThatAddsResources(loc))
}

func MakeLocsPrintable(locs []Location, factory PrintableLocFactory) []util.Printable {
	var nPrints []util.Printable
	for _, loc := range locs {
		printer := factory.CreatePrintable(loc)
		nPrints = append(nPrints, printer)
	}
	return nPrints
}

func createSomeDetailsThatAddsResources(loc someDetailsPrint) string {
	var formatString string

	for _, thisRec := range loc.Resources {
		formatString += fmt.Sprintf(" %s | %d |", thisRec.name, thisRec.quantity)
	}

	return formatString
}
