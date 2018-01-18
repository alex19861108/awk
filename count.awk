function ceil(value, interval) {
	return (int(value / interval) + 1) * interval
}

function floor(value, interval) {
	return int(value / interval) * interval
}

BEGIN{
	sum = 0
	interval = 1
} {
	count[floor($1, interval)] += 1
	sum += $1
}
END {
	for (k in count) {
		print k"---"k+interval "\t" count[k] | "sort -n"
	}
	print "sum\t"sum
	print "average\t"sum/NR
}
