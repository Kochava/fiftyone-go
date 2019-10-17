package main

import (
	"fmt"

	"github.com/Kochava/fiftyone-go/fiftyonepattern"
)

func main() {
	var (
		provider fiftyonepattern.Provider = fiftyonepattern.NewProvider("./data/51Degrees-LiteV3.2.dat")
		match                             = provider.GetMatch("test")
	)

	fiftyonepattern.DeleteMatch(match)

	fmt.Println("HardwareName: ", match.GetValue("HardwareName"))
}
