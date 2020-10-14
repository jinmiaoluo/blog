package main

import (
	"fmt"
)

func divide(a, b int) (remainder int, quotient int) {
	remainder = a % b
	quotient = a / b
	return
}

func main() {
	var a int = 9
	var b int = 4
	r, q := divide(a, b)
	fmt.Printf("remainder  %d quotient: %d\n", r, q)
}
