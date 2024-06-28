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
func Ping() (float64, float64, error) {
	// Load environment variables from .env file
	err := godotenv.Load()
	if err != nil {
		fmt.Println("Error loading .env file")
		return 0, 0, fmt.Errorf("error loading .env file: ", err)
	}
	googleGeolocationKey := os.Getenv("GOOGLE_GEOLOCATION_KEY")
	windowsBSSID, err := wifi.GetWifiInfoWindows()
	if err != nil {
		return 0, 0, fmt.Errorf("error getting wifi info: ", err)
	}

	wifiAccess := WiFiAccessPoint{
		MacAddress: windowsBSSID,
	}

	geoRequest := GeoLocationRequest{WiFiAccessPoints: []WiFiAccessPoint{wifiAccess}}

	reqBody, err := json.Marshal(geoRequest)
	if err != nil {
		return 0, 0, fmt.Errorf("json marshalling went awry: ", err)
	}
	url := "https://www.googleapis.com/geolocation/v1/geolocate?key=" + googleGeolocationKey
	resp, err := http.Post(url, "application/json", bytes.NewBuffer(reqBody))
	if err != nil {
		return 0, 0, fmt.Errorf("http post err: ", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return 0, 0, fmt.Errorf("received non-200 response code: %d", resp.StatusCode)
	}

	var result map[string]interface{}
	err = json.NewDecoder(resp.Body).Decode(&result)
	if err != nil {
		fmt.Println("json decoding went awry... ", err)
		return 0, 0, fmt.Errorf("ping error on decoding resp", err)
	}
	lat := float64(result["location"].(map[string]interface{})["lat"].(float64))
	long := float64(result["location"].(map[string]interface{})["lng"].(float64))
	fmt.Println(lat, long)
	return lat, long, nil
}
