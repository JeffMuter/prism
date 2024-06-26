package user

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/joho/godotenv"
	"net/http"
	"os"
	"prism/wifi"
)

type GeoLocationRequest struct {
	WiFiAccessPoints []WiFiAccessPoint `json:"wifiAccessPoints"`
}

type WiFiAccessPoint struct {
	MacAddress string `json:"macAddress"`
}

// Ping this function will use ipinfo, which gathers some super rough location estimates.
// but gives us more of what we need for google's geolocation api.
func Ping() {
	fmt.Println("found you...")
	// Load environment variables from .env file
	err := godotenv.Load()
	if err != nil {
		fmt.Println("Error loading .env file")
		return
	}
	googleGeolocationKey := os.Getenv("GOOGLE_GEOLOCATION_KEY")
	windowsBSSID, err := wifi.GetWifiInfoWindows()
	if err != nil {
		fmt.Println("my brother in christ, the windows bssid failed: ", err)
	}

	wifiAccess := WiFiAccessPoint{
		MacAddress: windowsBSSID,
	}

	geoRequest := GeoLocationRequest{WiFiAccessPoints: []WiFiAccessPoint{wifiAccess}}

	reqBody, err := json.Marshal(geoRequest)
	if err != nil {
		fmt.Println("json marshalling went awry... ", err)
		return
	}
	url := "https://www.googleapis.com/geolocation/v1/geolocate?key=" + googleGeolocationKey
	resp, err := http.Post(url, "application/json", bytes.NewBuffer(reqBody))
	if err != nil {
		fmt.Println("http post err: ", err)
		return
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		fmt.Println("Error: received non-200 response code", resp.StatusCode)
		return
	}

	var result map[string]interface{}
	err = json.NewDecoder(resp.Body).Decode(&result)
	if err != nil {
		fmt.Println("json decoding went awry... ", err)
		return
	}
	fmt.Println(result)
}
