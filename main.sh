#!/bin/bash

# Define the log file location
log_file="/var/log/nginx/access.log"

# Define the report file location
report_file="site_usage_report.txt"

# Get the total number of requests
total_requests=`cat $log_file | wc -l`

# Get the number of unique IP addresses
unique_ips=`cat $log_file | awk '{print $1}' | sort | uniq | wc -l`

# Get the top 10 most frequently requested pages
most_requested=`cat $log_file | awk '{print $7}' | sort | uniq -c | sort -nr | head -n 10`

# Get the average request size
average_size=`cat $log_file | awk '{sum+=$10} END {print sum/NR}'`

# Write the report data to the report file
echo "Site Usage Report" > $report_file
echo "Total Requests: $total_requests" >> $report_file
echo "Unique IP Addresses: $unique_ips" >> $report_file
echo "Top 10 Most Frequently Requested Pages:" >> $report_file
echo "$most_requested" >> $report_file
echo "Average Request Size: $average_size" >> $report_file

# Display the report file contents
cat $report_file
