#!/bin/bash
if [ -z $1 ]; then
  echo "Usage: run-sumulation.sh <simulation filename>"
  exit 1
fi

GATLING_SIMULATIONS_DIR='nft'
GATLING_RESULTS_DIR=$PWD/results

echo "Loading simulation $1"
# gatling.sh -sf $GATLING_SIMULATIONS_DIR -rf $GATLING_RESULTS_DIR -m -s $1 > gatling.log 2>&1 &
gatling.sh -sf $GATLING_SIMULATIONS_DIR -rf $GATLING_RESULTS_DIR -s $1 
