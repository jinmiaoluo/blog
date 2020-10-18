package main

import (
	"fmt"
)

func Init(a, b, c, d, e, f, g, h *int) {
	*a = 0
	*b = 1
	*c = 2
	*d = 3
	*e = 4
	*f = 5
	*g = 6
	*h = 7
}

func main() {
	var a int
	var b int
	var c int
	var d int
	var e int
	var f int
	var g int
	var h int
	Init(&a, &b, &c, &d, &e, &f, &g, &h)
	fmt.Println(a, b, c, d, e, f, g, h)
}
