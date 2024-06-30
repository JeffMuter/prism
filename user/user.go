package user

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/joho/godotenv"
	"net/http"
	"os"
	"prism/operating_system"
)

type User struct {
	Id       int
	Username string
	Email    string
	Password string
}

type GeoLocationRequest struct {
	WiFiAccessPoints []WiFiAccessPoint `json:"wifiAccessPoints"`
}

type WiFiAccessPoint struct {
	MacAddress string `json:"macAddress"`
}

// Ping this function will use Google's geolocate api, which gathers some super rough location estimates.
func Ping() (float64, float64, error) {
	// Load environment variables from .env file
	err := godotenv.Load()
	if err != nil {
		fmt.Println("Error loading .env file")
		return 0, 0, fmt.Errorf("error loading .env file:  %v", err)
	}
	googleGeolocationKey := os.Getenv("GOOGLE_GEOLOCATION_KEY")
	osBSSID, err := operating_system.GetWifiInfo()
	if err != nil {
		return 0, 0, fmt.Errorf("error getting wifi info: %v", err)
	}

	wifiAccess := WiFiAccessPoint{
		MacAddress: osBSSID,
	}

	geoRequest := GeoLocationRequest{WiFiAccessPoints: []WiFiAccessPoint{wifiAccess}}

	reqBody, err := json.Marshal(geoRequest)
	if err != nil {
		return 0, 0, fmt.Errorf("json marshalling went awry: %v", err)
	}
	url := "https://www.googleapis.com/geolocation/v1/geolocate?key=" + googleGeolocationKey
	resp, err := http.Post(url, "application/json", bytes.NewBuffer(reqBody))
	if err != nil {
		return 0, 0, fmt.Errorf("http post err: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return 0, 0, fmt.Errorf("received non-200 response code: %d", resp.StatusCode)
	}

	var result map[string]interface{}
	err = json.NewDecoder(resp.Body).Decode(&result)
	if err != nil {
		fmt.Println("json decoding went awry... ", err)
		return 0, 0, fmt.Errorf("ping error on decoding resp: %v", err)
	}
	lat := result["location"].(map[string]interface{})["lat"].(float64)
	long := result["location"].(map[string]interface{})["lng"].(float64)
	fmt.Println(lat, long)
	return lat, long, nil
}
