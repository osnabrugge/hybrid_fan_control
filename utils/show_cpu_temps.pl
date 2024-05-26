#!/usr/bin/perl

sub get_cpu_temp_ipmi
{
    # Get the number of CPUs (sockets)
    my $num_cpus = `lscpu | grep 'Socket(s):' | awk '{print \$2}'`;
    chomp $num_cpus;

    my @cpu_temps;

    # Loop over each CPU and get the temperature
    for (my $i = 1; $i <= $num_cpus; $i++) {
        my $cpu_temp = `ipmitool sensor get \"CPU$i Temp\" | awk '/Sensor Reading/{print \$4}'`;
        chomp $cpu_temp;

        print "CPU$i Temp: $cpu_temp\n";
        
        push @cpu_temps, $cpu_temp;
    }

    # Note, these haven't been cleaned.
    $last_cpu_temp = $cpu_temps[-1];

    return @cpu_temps;
}

# Call the function
get_cpu_temp_ipmi();