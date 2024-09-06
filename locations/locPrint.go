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
	return fmt.Sprintf("%s", loc.Named)
}

type someDetailsPrint struct{ Location }
type SomeDetailsPrintFactory struct{}

func (factory SomeDetailsPrintFactory) CreatePrintable(loc Location) util.Printable {
	return someDetailsPrint{Location: loc}
}

func (loc someDetailsPrint) StringToPrint() string {
	return fmt.Sprintf("  %s  | %s  | ", loc.Name, loc.LocationType)
}

func MakeLocsPrintable(locs []Location, factory PrintableLocFactory) []util.Printable {
	var nPrints []util.Printable
	for _, loc := range locs {
		printer := factory.CreatePrintable(loc)
		nPrints = append(nPrints, printer)
	}
	return nPrints
}
