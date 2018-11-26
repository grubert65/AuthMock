#!/bin/bash

EXPERIMENTS_DIR='experiments'
GATLING_SIMULATIONS_DIR='.'
GATLING_RESULTS_DIR=$PWD/results

if [ ! -d "$EXPERIMENTS_DIR" ]; then

  echo "Chaos::Toolkit experiments directory $EXPERIMENTS_DIR not found,
  exiting...\n"

  exit 1

fi

function run_experiment {
    echo "Running experiment $1, logs into chaos.log"
    chaos.pl -experiment $EXPERIMENTS_DIR/$1.json > chaos.log 2>&1 &
}

function run_simulation {
    echo "Loading simulation $1, logs into gatling.log"
    gatling.sh -sf $GATLING_SIMULATIONS_DIR -rf $GATLING_RESULTS_DIR -m -s $1 > gatling.log 2>&1 &
}

echo "###############################################"
echo "# First experiment:                           #"
echo "# App under Peak load and latency in Cache    #"
echo "###############################################"
run_simulation simulations.PeakAndSoak
run_experiment add_latency
