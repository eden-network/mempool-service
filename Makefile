.PHONY:
genproto:
	protoc -I=./protobuf --go_opt=paths=source_relative \
		--go_opt=paths=source_relative \
		--go_out=./protobuf \
		--go-grpc_out=./protobuf \
		--go-grpc_opt=paths=source_relative \
		mempool-service.proto