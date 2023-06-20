#!/usr/bin/perl

my $cpu_usage = sprintf("%.2f",`snmpwalk -v2c -c private 127.0.0.1 laLoad.1 | awk -F' ' '{print \$4}' | tr -d '%'`);

my $mem_usage = `snmpwalk -v2c -c private 127.0.0.1 memAvailReal | awk -F' ' '{print \$4}'`;
my $total_mem = `snmpwalk -v2c -c private 127.0.0.1 memTotalReal | awk -F' ' '{print \$4}'`;
my $mem_usage_percentage = sprintf("%.2f", (($total_mem - $mem_usage) / $total_mem));

my $response = '<html><body>['.$cpu_usage.']['.$mem_usage_percentage.']</html></body>';

 open(my $fh,">/var/www/html/index.html");
 print $fh "$response";
 close($fh);