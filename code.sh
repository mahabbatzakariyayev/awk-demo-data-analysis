#!/bin/bash


curl -s "https://people.sc.fsu.edu/~jburkardt/data/csv/grades.csv" > grades.csv


echo "First 3 lines:"
awk 'NR<=3 {print}' grades.csv


echo " 1.2 Print specific fields (First name, Last name):"
echo "Command: awk -F',' '{print \$2, \$1}' grades.csv"
awk -F',' 'NR<=5 {print $2, $1}' grades.csv
echo ""

echo " 1.3 Print with custom formatting:"
echo "Command: awk -F',' '{printf \"%-15s %-15s\\n\", \$2, \$1}' grades.csv"
awk -F',' 'NR<=5 {printf "%-15s %-15s\n", $2, $1}' grades.csv
echo ""


echo "LESSON 2: FIELD SEPARATORS & RECORD PROCESSING"
echo "==============================================="
echo ""

echo " 2.1 Using different field separator (-F option):"
echo "Command: awk -F',' 'NR==1 {print \"Fields:\", NF}' grades.csv"
awk -F',' 'NR==1 {print "Fields:", NF}' grades.csv
echo ""

echo "2.2 Processing records with conditions (skip header):"
echo "Command: awk -F',' 'NR>1 {print \$2, \$1, \"Grade:\", \$9}' grades.csv"
awk -F',' 'NR>1 && NR<=5 {print $2, $1, "Grade:", $9}' grades.csv
echo ""

echo " 2.3 Count total records:"
echo "Command: awk 'END {print \"Total records:\", NR}' grades.csv"
awk 'END {print "Total records:", NR}' grades.csv
echo ""


echo "LESSON 3: PATTERN MATCHING & FILTERING"
echo "======================================"
echo ""

echo " 3.1 Filter by grade (A students only):"
echo "Command: awk -F',' '\$9 ~ /^\"A/ {print \$2, \$1, \$9}' grades.csv"
awk -F',' '$9 ~ /^"A/ {print $2, $1, $9}' grades.csv
echo ""

echo " 3.2 Filter by numeric condition (Test1 > 45):"
echo "Command: awk -F',' 'NR>1 && \$4 > 45 {print \$2, \$1, \"Test1:\", \$4}' grades.csv"
awk -F',' 'NR>1 && $4 > 45 {print $2, $1, "Test1:", $4}' grades.csv
echo ""

echo " 3.3 Multiple conditions (B grades AND Test1 > 40):"
echo "Command: awk -F',' 'NR>1 && \$9 ~ /B/ && \$4 > 40 {print \$2, \$1, \$4, \$9}' grades.csv"
awk -F',' 'NR>1 && $9 ~ /B/ && $4 > 40 {print $2, $1, $4, $9}' grades.csv
echo ""


echo "LESSON 4: VARIABLES & CALCULATIONS"
echo "=================================="
echo ""

echo "🧮 4.1 Calculate sum and average of Test1:"
echo "Command: awk -F',' 'NR>1 {sum += \$4; count++} END {print \"Sum:\", sum, \"Average:\", sum/count}' grades.csv"
awk -F',' 'NR>1 {sum += $4; count++} END {print "Sum:", sum, "Average:", sum/count}' grades.csv
echo ""

echo " 4.2 Find maximum and minimum scores in Test1:"
echo "Command: awk -F',' 'NR==2{min=max=\$4} NR>1{if(\$4<min) min=\$4; if(\$4>max) max=\$4} END{print \"Min:\", min, \"Max:\", max}' grades.csv"
awk -F',' 'NR==2{min=max=$4} NR>1{if($4<min) min=$4; if($4>max) max=$4} END{print "Min:", min, "Max:", max}' grades.csv
echo ""

echo "4.3 Calculate test average for each student:"
echo "Command: awk -F',' 'NR>1 {avg = (\$4+\$5+\$6+\$7)/4; printf \"%-15s: %.1f\\n\", \$2\" \"\$1, avg}' grades.csv"
awk -F',' 'NR>1 {avg = ($4+$5+$6+$7)/4; printf "%-15s: %.1f\n", $2" "$1, avg}' grades.csv
echo ""


echo "📊 5.1 Count students by grade:"
echo "Command: awk -F',' 'NR>1 {grade_count[\$9]++} END {for(g in grade_count) print g, grade_count[g]}' grades.csv"
awk -F',' 'NR>1 {grade_count[$9]++} END {for(g in grade_count) print g, grade_count[g]}' grades.csv
echo ""

echo "📊 5.2 Sum scores by grade level:"
echo "Command: awk -F',' 'NR>1 {grade=\$9; sum[grade]+=\$4; count[grade]++} END {for(g in sum) printf \"%s: avg=%.1f\\n\", g, sum[g]/count[g]}' grades.csv"
awk -F',' 'NR>1 {grade=$9; sum[grade]+=$4; count[grade]++} END {for(g in sum) printf "%s: avg=%.1f\n", g, sum[g]/count[g]}' grades.csv
echo ""

echo "📊 5.3 Create grade distribution table:"
awk -F',' 'BEGIN{print "Grade Distribution:"; print "=================="} 
NR>1 {grades[$9]++; total++} 
END {
    for(g in grades) {
        printf "%-3s: %2d students (%.1f%%)\n", g, grades[g], (grades[g]/total)*100
    }
}' grades.csv
echo ""



echo "Command with BEGIN block:"
awk -F',' 'BEGIN{print "Student Performance Report"; print "=========================="; total=0} 
NR>1 {total++; if($4>=80) high_performers++} 
END{printf "High performers (Test1>=80): %d out of %d (%.1f%%)\n", high_performers, total, (high_performers/total)*100}' grades.csv
echo ""

awk -F',' 'BEGIN{print "Class Statistics Summary:"}
NR>1 {
    # Collect all test scores
    sum_test1 += $4; sum_test2 += $5; sum_test3 += $6; sum_test4 += $7; sum_final += $8
    count++
    
    # Count passing grades (C or better)
    if($9 ~ /^"[ABC]/) passing++
}
END {
    printf "Students: %d\n", count
    printf "Test 1 Average: %.1f\n", sum_test1/count
    printf "Test 2 Average: %.1f\n", sum_test2/
