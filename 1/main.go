package adventofcode1

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func calculatePart1() int {
	fileData, err := os.ReadFile("input.txt")
	check(err)
	dataByLine := strings.Split(string(fileData), "\n")
	reNumber := regexp.MustCompile(`(\d)`)
	sum := 0
	for _, line := range dataByLine {
		numbers := reNumber.FindAllString(line, -1)
		if len(numbers) == 0 {
			continue
		}
		stringNumber := numbers[0] + numbers[len(numbers)-1]
		number, err := strconv.Atoi(stringNumber)
		check(err)
		sum += number
	}
	fmt.Println(sum)
	return sum
}

var stringToNumber = map[string]string{
	"one":   "1",
	"two":   "2",
	"three": "3",
	"four":  "4",
	"five":  "5",
	"six":   "6",
	"seven": "7",
	"eight": "8",
	"nine":  "9",
}

func calculatePart2() int {
	fileData, err := os.ReadFile("input.txt")
	check(err)
	dataByLine := strings.Split(string(fileData), "\n")
	stringNumbers := []string{}
	for stringNumber, _ := range stringToNumber {
		stringNumbers = append(stringNumbers, stringNumber)
	}
	regexForStringNumber := strings.Join(stringNumbers, "|")
	reNumber := regexp.MustCompile(`^(\d|` + regexForStringNumber + `)`)
	sum := 0
	for _, line := range dataByLine {
		numbers := make([]string, 0)
		for index, _ := range line {
			_numbers := reNumber.FindAllString(line[index:], -1)
			if len(_numbers) > 0 {
				numbers = append(numbers, _numbers[0])
			}
		}
		if len(numbers) == 0 {
			continue
		}
		firstDigit, ok := stringToNumber[numbers[0]]
		if !ok {
			firstDigit = numbers[0]
		}
		length := len(numbers) - 1
		lastDigit, ok := stringToNumber[numbers[length]]
		if !ok {
			lastDigit = numbers[length]
		}
		stringNumber := firstDigit + lastDigit
		number, err := strconv.Atoi(stringNumber)
		check(err)
		sum += number
	}
	fmt.Println(sum)
	return sum
}
