package main

import (
	"fmt"
	"log"
	"os"
	"prism/db"
	"prism/logic"
	"prism/menus"
	"prism/render"
	"prism/user"
	"runtime"
	"runtime/pprof"
	"time"
)

func main() {
	// CPU profiling
	cpuFile, err := os.Create("cpu.prof")
	if err != nil {
		panic(err)
	}
	defer cpuFile.Close()

	pprof.StartCPUProfile(cpuFile)
	defer pprof.StopCPUProfile()

	err = db.OpenDatabase()

	if err != nil {
		log.Fatalf("db connections failed...: %v", err)
	}

	fmt.Println(time.Now())

	var thisUser = user.User{
		Id:       1,
		Username: "1",
		Email:    "1@gmail.com",
		Password: "1",
	}

	thisUser.Latitude, thisUser.Longitude, err = user.Ping()
	fmt.Printf("Lat: %v\nLong: %v\n", thisUser.Latitude, thisUser.Longitude)

	if err != nil {
		fmt.Println(err)
	}

	err = logic.UpdateAllLocationsResourcesQuantities(thisUser.Id)

	if err != nil {
		err = fmt.Errorf("error updating all user's locations quantities: %v", err)
		fmt.Println(err)
	}

	_, err = render.PaintScreen(&thisUser)

	if err != nil {
		err = fmt.Errorf("error from painting screen: %w\n", err)
		fmt.Println(err)
	}

	err = menus.MainMenuListen(thisUser)

	if err != nil {
		fmt.Println(fmt.Errorf("problem in main menu: %v", err))
	} else {

		fmt.Println("Main menu closed...")
	}

	// Memory profiling
	memFile, err := os.Create("mem.prof")
	if err != nil {
		panic(err)
	}
	defer memFile.Close()

	runtime.GC() // Force GC before memory profile
	pprof.WriteHeapProfile(memFile)
}
