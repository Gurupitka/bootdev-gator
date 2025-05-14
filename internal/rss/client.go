package rss

import (
	"net/http"
	"encoding/xml"
	"html"
	"io"
)


func FetchFeed(feedURL string) (*RSSFeed, error) {
	var results RSSFeed	
	client := &http.Client{}
	req, err := http.NewRequest("GET",feedURL,nil)
	if err != nil {
		return nil,err
	}
	resp, err := client.Do(req)
	if err != nil {
		return nil,err
	}
	defer resp.Body.Close()	
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil,err
	}
	err = xml.Unmarshal(body,&results)
	if err != nil {
		return nil,err
	}
	
	results.Channel.Title = html.UnescapeString(results.Channel.Title)
	results.Channel.Description = html.UnescapeString(results.Channel.Description)	
	return &results, nil
}
