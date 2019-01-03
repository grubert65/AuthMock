#!/bin/bash

GATLING_SIMULATIONS_DIR='.'
GATLING_RESULTS_DIR=$PWD/results

echo "Loading simulation $1, logs into gatling.log"
gatling.sh -sf $GATLING_SIMULATIONS_DIR -rf $GATLING_RESULTS_DIR -m -s $1 > gatling.log 2>&1 &
