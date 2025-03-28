package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

func firstTask(line, subline string) bool {
	if len(line) != len(subline) {
		return false
	}
	doubleLine := line + line
	return strings.Contains(doubleLine, subline)
}

func secondTask(line string) bool {
	alphabet := "qwertyuiopasdfghjklzxcvbnm"
	if strings.Contains(line, " ") {
		alphabet += " "
	}

	for _, symbol := range alphabet {
		if !strings.ContainsRune(line, symbol) {
			return false
		}
	}
	return true
}

func main() {
	const (
		first  = 1
		second = 2
		third  = 3
	)

	scanner := bufio.NewScanner(os.Stdin)
	move := true

	fmt.Print("Введите модуль (1-3):\n1 - 1.3\n2 - 2.9\n3 - 3.19\n ")
	scanner.Scan()
	menu, err := strconv.Atoi(scanner.Text())
	if err != nil || menu < 1 || menu > 3 {
		fmt.Println("Неверный ввод")
		return
	}

	switch menu {
	case first:
		fmt.Print("Введите строку: ")
		scanner.Scan()
		line := strings.TrimSpace(scanner.Text())

		fmt.Print("Введите подстроку: ")
		scanner.Scan()
		subline := strings.TrimSpace(scanner.Text())

		if firstTask(line, subline) {
			fmt.Println("Yes")
		} else {
			fmt.Println("No")
		}

	case second:
		validChars := "qwertyuiopasdfghjklzxcvbnm "
		var line string
		for {
			fmt.Print("Введите строку: ")
			scanner.Scan()
			line = strings.TrimSpace(scanner.Text())

			valid := true
			for _, c := range line {
				if !strings.ContainsRune(validChars, c) {
					fmt.Printf("Ошибка! Недопустимый символ: '%c'\n", c)
					valid = false
					break
				}
			}

			if valid {
				break
			}
		}

		if secondTask(line) {
			fmt.Println("Yes")
		} else {
			fmt.Println("No")
		}

	case third:
		fmt.Println("Введите числа через пробел:")
		scanner.Scan()
		input := strings.Fields(scanner.Text())

		if len(input) == 0 {
			fmt.Println("Ошибка! Не введены числа")
			return
		}

		count := 0
		prev := math.Abs(float64(parseNumber(input[0])))
		for i := 1; i < len(input); i++ {
			current := math.Abs(float64(parseNumber(input[i])))
			if current == prev {
				count++
			}
			prev = current
		}

		fmt.Printf("Количество чисел равных предыдущему: %d\n", count)

	default:
		fmt.Println("Неверный выбор")
	}

	if move {
		fmt.Print("Желаете выйти в меню выбора языка?\n1 - Да\n2 - Нет\n ")
		scanner.Scan()
		choice, _ := strconv.Atoi(scanner.Text())

		switch choice {
		case 1:
			exec.Command("code", "/home/nomask776/Laboratory_work_second/main.cpp").Run()
		case 2:
			exec.Command("code", "Go.go").Run()
		default:
			fmt.Println("Неверный ввод")
			return
		}
	}
}

func parseNumber(s string) int {
	num, err := strconv.Atoi(s)
	if err != nil || num == 0 {
		fmt.Println("Ошибка! Некорректное число:", s)
		os.Exit(1)
	}
	return num
}
