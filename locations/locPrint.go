package locations

import (
	"fmt"
	"prism/util"
)

type namePrint struct {
	Location
}

func (loc namePrint) StringToPrint() string {
	return fmt.Sprintf("%s", loc.Name)
}

func MakeLocsPrintable(locs []Location) []util.Printable {
	var nPrints []util.Printable
	for _, loc := range locs {
		printer := namePrint{Location: loc}
		nPrints = append(nPrints, printer)
	}
	return nPrints
}
