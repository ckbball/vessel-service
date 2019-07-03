build:
	protoc -I=$(GOPATH)/src/github.com/ckbball/micro-tut/vessel-service/proto/vessel --go_out=plugins=micro:$(GOPATH)/src/github.com/ckbball/micro-tut/vessel-service/proto/vessel/ $(GOPATH)/src/github.com/ckbball/micro-tut/vessel-service/proto/vessel/vessel.proto
	docker build -t vessel-service .


