<?php

define('FIRST', 1);
define('SECOND', 2);
define('THIRD', 3);

function first_task($line, $subline) {
    $double_line = $line . $line;
    if (strlen($line) != strlen($subline)) {
        return false;
    } elseif (strpos($double_line, $subline) !== false) {
        return true;
    } else {
        return false;
    }
}

function second_task($line) {
    $alphabet = "qwertyuiopasdfghjklzxcvbnm";
    if (strpos($line, " ") !== false) {
        $alphabet .= " ";
    }
    for ($i = 0; $i < strlen($alphabet); $i++) {
        $symbol = $alphabet[$i];
        if (strpos($line, $symbol) === false) {
            return false;
        }
    }
    return true;
}

function main() {
    global $move;
    
    echo "Введите модуль \n 1 - 1.3 \n 2 - 2.9 \n 3 - 3.19\n";
    $menu = (int)trim(fgets(STDIN));
    
    $move = true;
    
    switch ($menu) {
        case FIRST:
            echo "Введите строку\n";
            $line = trim(fgets(STDIN));
            echo "Введите подстроку\n";
            $subline = trim(fgets(STDIN));
            $function_first = first_task($line, $subline);
            echo $function_first ? "Yes\n" : "No\n";
            break;
            
        case SECOND:
            $checkout_input = "qwertyuiopasdfghjklzxcvbnm ";
            while (true) {
                echo "Введите строку\n";
                $line = trim(fgets(STDIN));
                $valid = true;
                for ($i = 0; $i < strlen($line); $i++) {
                    $symbol = $line[$i];
                    if (strpos($checkout_input, $symbol) === false) {
                        echo "Ошибка! Недопустимый символ: '" . $symbol . "'. Повторите ввод:\n";
                        $valid = false;
                        break;
                    }
                }
                if ($valid) {
                    break;
                }
            }
            $function = second_task($line);
            echo $function ? "Yes\n" : "No\n";
            break;
            
            case THIRD:
                echo "Введите числа через пробел:\n";
                $input = fgets(STDIN);
                
                $currentNumber = 0;
                $previousNumber = 0;
                $count = 0;
                $isFirst = true;
                $isNegative = false;
                $hasError = false;
                
                $i = 0;
                while ($i < strlen($input)) {
                    $char = $input[$i];
                    
                    if ($char == ' ') {
                        $i++;
                        continue;
                    }
                    
                    if ($char == '-') {
                        if ($isNegative) {
                            $hasError = true;
                            break;
                        }
                        $isNegative = true;
                        $i++;
                        continue;
                    }
                    
                    if (!ctype_digit($char)) {
                        if ($char != "\n" && $char != "\r") {
                            $hasError = true;
                        }
                        $i++;
                        continue;
                    }
                    
                    $num = 0;
                    while ($i < strlen($input) && ctype_digit($input[$i])) {
                        $num = $num * 10 + (int)$input[$i];
                        $i++;
                    }
                    
                    if ($isNegative) {
                        $num = -$num;
                        $isNegative = false;
                    }
                    if ($isFirst) {
                        $previousNumber = $num;
                        $isFirst = false;
                    } else {
                        if ($num == $previousNumber) {
                            $count++;
                        }
                        $previousNumber = $num;
                    }
                }
                
                if ($hasError) {
                    echo "Ошибка! Некорректный ввод.\n";
                    $move = false;
                    main();
                } else {
                    echo "Количество чисел, равных предыдущему: " . $count . "\n";
                }
                break;
    }
    
    while ($move) {
        echo "Желаете выйти в меню выбора языка? \n 1 - Yes \n 2 - No\n";
        $move_menu = (int)trim(fgets(STDIN));
        if ($move_menu == 1) {
            system("code /home/nomask776/Laboratory_work_second/main.cpp");
            $move = false;
        } elseif ($move_menu == 2) {
            main();
            $move = false;
        } else {
            echo "Неверный ввод\n";
        }
    }
}

$move = true;
main();