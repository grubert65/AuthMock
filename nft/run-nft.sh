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
    echo "Running experiment $1"
    chaos.pl -experiment $EXPERIMENTS_DIR/$1.json > chaos.log 2>&1 &
}

function run_simulation {
    echo "Loading simulation $1"
    gatling.sh -sf $GATLING_SIMULATIONS_DIR -rf $GATLING_RESULTS_DIR -m -s $1 > /tmp/gatling.log 2>&1 &
}

function update_report {
    if [ -f journal.json ]; then
        backup_dir=backup/`date '+%Y-%m-%d-%H-%M'`
        if [ ! -d "$backup_dir" ]; then
            mkdir $backup_dir
        fi
        journal_path=$backup_dir/journal.json
        mv journal.json $journal_path
        report_dir=`get-gatling-report.pl results`
        #mv ./gatling.log $backup_dir/.
        update-gatling-report.pl -report_dir $PWD/$report_dir -ct_journal $journal_path
    fi
}

echo "###############################################"
echo "# First experiment:                           #"
echo "# App under Peak load and latency in Cache    #"
echo "###############################################"
run_simulation simulations.PeakAndSoak
sleep 10
run_experiment add_latency
# 
update_report
