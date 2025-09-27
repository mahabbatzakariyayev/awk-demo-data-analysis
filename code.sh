#!/bin/bash

#curl -s "https://people.sc.fsu.edu/~jburkardt/data/csv/grades.csv" > grades.csv
#
curl -s "https://raw.githubusercontent.com/mahabbatzakariyayev/awk-demo-data-analysis/refs/heads/main/grades.csv"  > grades.csv
echo "Print first 3 lines:"
awk 'NR<=3 {print}' grades.csv

echo "Print first name and last name:"
awk -F',' 'NR<=5 {print $2, $1}' grades.csv

#
echo "Count number of fields:"
awk -F',' 'NR==1 {print "Fields:", NF}' grades.csv

echo "Print names and grades (skip header):"
awk -F',' 'NR>1 && NR<=5 {print $2, $1, "Grade:", $9}' grades.csv

echo "Count total records:"
awk 'END {print "Total records:", NR}' grades.csv


#
echo "Find students with A grades:"
awk -F',' '$9 ~ /^"A/ {print $2, $1, $9}' grades.csv

#
echo "Find students with Test1 > 45:"
awk -F',' 'NR>1 && $4 > 45 {print $2, $1, "Test1:", $4}' grades.csv

#
echo "Find B grade students with Test1 > 40:"
awk -F',' 'NR>1 && $9 ~ /B/ && $4 > 40 {print $2, $1, $4, $9}' grades.csv

#
echo "Calculate Test1 sum and average:"
awk -F',' 'NR>1 {sum += $4; count++} END {print "Sum:", sum, "Average:", sum/count}' grades.csv

##
echo "Find Test1 min and max scores:"
awk -F',' 'NR==2{min=max=$4} NR>1{if($4<min) min=$4; if($4>max) max=$4} END{print "Min:", min, "Max:", max}' grades.csv

###
echo "Calculate test average for each student:"
awk -F',' 'NR>1 {avg = ($4+$5+$6+$7)/4; printf "%-15s: %.1f\n", $2" "$1, avg}' grades.csv

#####
echo "Count students by grade:"
awk -F',' 'NR>1 {grade_count[$9]++} END {for(g in grade_count) print g, grade_count[g]}' grades.csv

echo "Average Test1 score by grade:"
awk -F',' 'NR>1 {grade=$9; sum[grade]+=$4; count[grade]++} END {for(g in sum) printf "%s: avg=%.1f\n", g, sum[g]/count[g]}' grades.csv
######

echo "Grade distribution with percentages:"
awk -F',' 'BEGIN{print "Grade Distribution:"; print "=================="} 
NR>1 {grades[$9]++; total++} 
END {
    for(g in grades) {
        printf "%-3s: %2d students (%.1f%%)\n", g, grades[g], (grades[g]/total)*100
    }
}' grades.csv

echo "Count high performers using BEGIN/END:"
awk -F',' 'BEGIN{print "Student Performance Report"; print "=========================="; total=0} 
NR>1 {total++; if($4>=80) high_performers++} 
END{printf "High performers (Test1>=80): %d out of %d (%.1f%%)\n", high_performers, total, (high_performers/total)*100}' grades.csv

echo "Complete class statistics:"
awk -F',' 'BEGIN{print "Class Statistics Summary:"}
NR>1 {
    sum_test1 += $4; sum_test2 += $5; sum_test3 += $6; sum_test4 += $7; sum_final += $8
    count++
    if($9 ~ /^"[ABC]/) passing++
}
END {
    printf "Students: %d\n", count
    printf "Test 1 Average: %.1f\n", sum_test1/count
    printf "Test 2 Average: %.1f\n", sum_test2/count
    printf "Test 3 Average: %.1f\n", sum_test3/count
    printf "Test 4 Average: %.1f\n", sum_test4/count
    printf "Final Average: %.1f\n", sum_final/count
    printf "Pass Ratxe: %.1f%%\n", (passing/count)*100
}' grades.csv