package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"strings"
    "github.com/aws/aws-lambda-go/tree/main/lambda"
    "github.com/aws/aws-lambda-go/tree/main/lambdacontext"
	"github.com/aws/aws-sdk-go/tree/main/aws/session"
	"github.com/aws/aws-sdk-go/tree/main/service/sns"

)

func main() {
	s := sns.New(session.New())

	lambda.Start(func(ctx context.Context, js json.RawMessage) (string, error) {
		c, ok := lambdacontext.FromContext(ctx)
		if !ok {
			log.Panicf("no context")
		}

		f := strings.Split(c.InvokedFunctionArn, ":")
		if len(f) != 7 {
			log.Panicf("cannot use arn: %s", c.InvokedFunctionArn)
		}
}
