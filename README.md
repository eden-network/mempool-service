# Mempool Service

Go package with pre-built gRPC client for the [Eden Mempool Service](https://docs.edennetwork.io/eden-mempool-streaming-service/overview).

## Installation

```bash
go get github.com/eden-network/mempool-service
```

## Usage

```go
import (
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	pb "mempool-service/protobuf"
	"os"
)

func main() {
	url := os.Getenv("EDEN_MEMPOOL_SERVICE_URL")
	authKey := os.Getenv("EDEN_MEMPOOL_SERVICE_AUTH")

	conn, err := grpc.Dial(url, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		return
	}

	client := pb.NewStreamServiceClient(conn)
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	stream, err := client.StreamRawTransactions(ctx, &pb.StreamRawTransactionsRequest{
		AuthHeader: authKey,
	})

	for {
		msg, err := stream.Recv()
		if err != nil {
			return
		}

		// do something with msg
	}
}
```