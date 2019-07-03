// vessel-service/main.go
package main

import (
  "context"
  "fmt"
  "log"
  "os"

  pb "github.com/ckbball/micro-tut/vessel-service/proto/vessel"
  "github.com/micro/go-micro"
)

const (
  defaultHost = "datastore:27017"
)

func main() {
  srv := micro.NewService(
    micro.Name("vessel-service"),
  )

  srv.Init()

  uri := os.Getenv("DB_HOST")
  if uri == "" {
    uri = defaultHost
  }
  client, err := CreateClient(uri)
  if err != nil {
    log.Panic(err)
  }
  defer client.Disconnect(context.TODO())

  vesselCollection := client.Database("shippy").Collection("vessel")
  repository := &VesselRepository{
    vesselCollection,
  }

  // Register our implementation with
  pb.RegisterVesselServiceHandler(srv.Server(), &handler{repository})

  if err := srv.Run(); err != nil {
    fmt.Println(err)
  }
}
