	cpuString=$(cat /proc/cpuinfo | grep 'model name' | uniq)
	cpu=$(echo "${cpuString:13}")