function ceil(value, interval) {
	return (int(value / interval) + 1) * interval
}

function floor(value, interval) {
	return int(value / interval) * interval
}

BEGIN{
	interval = 1
	sum = 0
	variance = 0
	std_deviation = 0
} {
	count[floor($1, interval)"---"ceil($1, interval)] += 1
	sum += $1
	data[NR] = $1
}
END {
	avg = sum/NR

	for (k in data) {
		variance += (data[k]-avg) * (data[k]-avg)
	}
	variance = variance/NR
	std_deviation = sqrt(variance)

	print "[sum]\t"sum
	print "[average]\t"avg
	print "[variance]\t"variance
	print "[standard deviation]\t"std_deviation "\n"

	print "[detail]"
	for (k in count) {
		print k "\t" count[k] "\t" count[k]/NR | "sort -n"
	}
}
