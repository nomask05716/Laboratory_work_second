import * as readlineSync from 'readline-sync';
import { spawn } from 'child_process';

function firstTask(line: string, subline: string): boolean {
    const doubleLine = line + line;
    if (line.length !== subline.length) {
        return false;
    } else if (doubleLine.includes(subline)) {
        return true;
    } else {
        return false;
    }
}

function secondTask(line: string): boolean {
    let alphabet = "qwertyuiopasdfghjklzxcvbnm";
    if (line.includes(" ")) {
        alphabet += " ";
    }
    for (const symbol of alphabet) {
        if (!line.includes(symbol)) {
            return false;
        }
    }
    return true;
}

function main() {
    console.log("Введите модуль \n 1 - 1.3 \n 2 - 2.9 \n 3 - 3.19");
    const menuInput = readlineSync.question();
    const menu = parseInt(menuInput);
    
    enum Module {
        First = 1,
        Second,
        Third,
    }
    
    let move = true;
    
    switch (menu) {
        case Module.First: {
            console.log("Введите строку");
            const line = readlineSync.question();
            console.log("Введите подстроку");
            const subline = readlineSync.question();
            const functionFirst = firstTask(line, subline);
            console.log(functionFirst ? "Yes" : "No");
            break;
        }
        case Module.Second: {
            const checkoutInput = "qwertyuiopasdfghjklzxcvbnm ";
            let line: string;
            while (true) {
                console.log("Введите строку");
                line = readlineSync.question().toLowerCase();
                let valid = true;
                for (const symbol of line) {
                    if (!checkoutInput.includes(symbol)) {
                        console.log(`Ошибка! Недопустимый символ: '${symbol}'. Повторите ввод:`);
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    break;
                }
            }
            const func = secondTask(line);
            console.log(func ? "Yes" : "No");
            break;
        }
        case Module.Third: {
            console.log("Введите числа через пробел");
            const input = readlineSync.question();
            const numbers = input.split(' ').map((num: string) => parseInt(num.trim()));
            
            if (numbers.some(isNaN) || numbers.length === 0 || numbers[numbers.length - 1] === 0) {
                console.log("Ошибка! Неверный ввод");
                main();
                return;
            }
            
            let first = true;
            let previousNumber: number = 0;
            let count = 0;
            
            for (const num of numbers) {
                const absNumber = Math.abs(num);
                if (first) {
                    previousNumber = absNumber;
                    first = false;
                } else {
                    if (absNumber === previousNumber) {
                        count++;
                    }
                    previousNumber = absNumber;
                }
            }
            
            console.log(`Количество чисел равных предыдущему = ${count}`);
            break;
        }
        default:
            console.log("Неверный ввод");
            move = false;
            main();
    }
    
    while (move) {
        console.log("Желаете выйти в меню выбора языка? \n 1 - Yes \n 2 - No");
        const moveMenuInput = readlineSync.question();
        const moveMenu = parseInt(moveMenuInput);
        if (moveMenu === 1) {
            spawn('code', ['/home/nomask776/Laboratory_work_second/main.cpp']);
            move = false;
        } else if(moveMenu === 2){
            main();
            move = false;
        }else{
            console.log("Неверный ввод");
        }
    }
}

main();