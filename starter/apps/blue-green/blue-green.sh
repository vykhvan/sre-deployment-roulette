#!/bin/bash

function green_deployment {
  kubectl apply -f green.yml -n udacity
  sleep 1
  NUM_GREEN_PODS=$(kubectl get pods -n udacity | grep -c green)
  echo "GREEN PODS: $NUM_GREEN_PODS"
  
  # Check deployment rollout status every 1 second until complete.
  ATTEMPTS=0
  ROLLOUT_STATUS_CMD="kubectl rollout status deployment/green -n udacity"
  until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 60 ]; do
    $ROLLOUT_STATUS_CMD
    ATTEMPTS=$((attempts + 1))
    sleep 1
  done
  echo "Green deployment of successful!"
}

# Begin green deployment
green_deployment
