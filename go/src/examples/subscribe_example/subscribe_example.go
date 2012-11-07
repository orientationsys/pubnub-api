package main

import (
	"log"
	"pubnub"
)

func main() {
	pub := pubnub.PubnubInit("demo", "demo", "", "", false)
	channel := make(chan []byte)

	//start new goroutine  
	go pub.Subscribe("my-channel", channel)

	//receive from channel
	for {
		log.Printf("%s", <-channel)
	}
}
