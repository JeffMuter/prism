package user

import (
	"fmt"
	geolocate "github.com/martinlindhe/google-geolocate"
	"log"
	"os"
)

func Ping() (*geolocate.GoogleGeo, error) {
	geolocationKey := os.Getenv("GEOLOCATION_KEY")
	if geolocationKey == "" {
		return nil, fmt.Errorf("GEOLOCATION_KEY environment variable not set")
	}

	client := geolocate.NewGoogleGeo(geolocationKey)
	location, err := client.Geolocate()
	if err != nil {
		log.Printf("Error getting geolocation: %v", err)
		return nil, err
	}

	fmt.Printf("Position: %v\n", location)
	return client, nil
}

func main() {
	client, err := Ping()
	if err != nil {
		log.Fatalf("Failed to get geolocation: %v", err)
	}

	fmt.Printf("Client: %v\n", client)
}
