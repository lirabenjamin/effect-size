#!/bin/bash

# Submit the array job
qsub -N MyRArrayJob -t 1-10 -b y "Rscript test_parallel/function.r"
