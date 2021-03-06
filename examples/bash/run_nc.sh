#!/bin/sh
# Copyright (c) 2016, David Stutz
# Contact: david.stutz@rwth-aachen.de, davidstutz.de
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Example of using and evaluating NC on the BSDS500.
# Supposed to be run from within examples/.

# ../nc_cli/nc_dispatcher.sh is the command line tool for NC indirectly calling MatLab.
# ../bin/eval_summary_cli takes the generated superpixel labels as CSV, the original
# images and ground truths as CSV to evaluate the superpixels.
# ../bin/eval_visualization_cli takes the generated superpixel labels as CSV, the
# original images and creates the specified visualizations (i.e. --contours).

# NOTE THAT NC NEEDS ADEQUATE COMPUTATIONAL RESOURCES. ON SOME LAPTOPS AND DESKTOPS
# RUNNING THIS SCRIPT MAY CAUSE PROBLEMS; ESPECIALLY UNDER UBUNTU DUE TO 
# SUBOPTIMAL MEMORY HANDLING.

# Note that both lib_tools and lib_nc need to be compiled using the make.m scripts.
# Note that this assumes the following setup:
# lib_nc/
# |- imncut_sp.m
# lib_pbedges/Detectors
# |- pbCGTG.m
# nc_cli/
# |- nc_dispatcher.m
# |- nc_cli.m
# lib_tools/
# |- fast_connected_relabel.cpp

# This should be the path to your matlab executable!
MATLAB="/home/david/MATLAB/R2015b/bin/matlab"

../nc_cli/nc_dispatcher.sh -i ../data/BSDS500/images/test/ -s 1200 -c 400 -g 40 -o ../output/nc -w -a ../nc_cli -e $MATLAB
../bin/eval_summary_cli --sp-directory ../output/nc --img-directory ../data/BSDS500/images/test --gt-directory ../data/BSDS500/csv_groundTruth/test
../bin/eval_visualization_cli --csv ../output/nc --images ../data/BSDS500/images/test --contours --vis ../output/nc