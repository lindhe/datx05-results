#!/bin/env gnuplot
###############################     TERMINAL     ###############################
set terminal pngcairo dashed size 1280,720
set output './number_of_readers.png'

################################     TITLE     ################################
set title 'Operation Latency: Increasing Number of Readers, 10 Writers'
set title font ",22"

#################################     AXIS     #################################
set yrange [0:1.5]
set key left top font ",20"
set ylabel 'Avg. operation latency [s]' font ",18"
set xlabel 'Number of Readers' font ",18"
set xti font ",18"
set yti font ",18"
set grid

##############################     LINE TYPE     ##############################
set linetype 1 lc rgb '#3366cc' # blue
set linetype 2 lc rgb '#dc3912' # red
set linetype 3 lc rgb '#ff9900' # yellow
set linetype 4 lc rgb '#109618' # green
set for [i=1:4] linetype i dt i ps 2.5 pt 7 lw 4

#################################     PLOT     #################################
plot 'test-readers_summary.csv'\
using 1:2 with linespoints lt 2 title "CASSS Read Latency",\
'' u 1:3 w linesp lt 1 tit "CASSS Write Latency",\

