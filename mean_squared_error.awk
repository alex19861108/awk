function ceil(value, interval) {
	return (int(value / interval) + 1) * interval
}

function floor(value, interval) {
	return int(value / interval) * interval
}

function abs(value) {
	return value < 0 ? -value : value
}

BEGIN{
	interval = 1
	sum = 0
	mean_squared_error = 0
	root_mean_squared_error = 0
} {
	count[floor($1, interval)"---"ceil($1, interval)] += 1
	sum += abs($1-$2)
	data[NR] = abs($1-$2)
}
END {
	avg = sum/NR

	for (k in data) {
		mean_squared_error += (data[k]-avg) * (data[k]-avg)
	}
	mean_squared_error = mean_squared_error/NR
	root_mean_squared_error = sqrt(mean_squared_error)

	print "[sum]\t"sum
	print "[average error]\t"avg
	print "[mean squared error]\t"mean_squared_error
	print "[root mean squared error]\t"root_mean_squared_error "\n"

	print "[detail]"
	for (k in count) {
		print k "\t" count[k] "\t" count[k]/NR | "sort -n"
	}
}
