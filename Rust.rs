use std::io;
use std::process::Command;

fn first_task(line: &str, subline: &str) -> bool {
    let double_line = line.to_string() + line;
    line.len() == subline.len() && double_line.contains(subline)
}

fn second_task(line: &str) -> bool {
    let mut alphabet = "qwertyuiopasdfghjklzxcvbnm".to_string();
    if line.contains(' ') {
        alphabet.push(' ');
    }
    alphabet.chars().all(|c| line.contains(c))
}

fn main() {
    println!("Введите модуль \n 1 - 1.3 \n 2 - 2.9 \n 3 - 3.19");

    let mut menu = String::new();
    io::stdin().read_line(&mut menu).unwrap();
    let menu: i32 = menu.trim().parse().unwrap();

    let mut move_flag = true;

    match menu {
        1 => {
            println!("Введите строку");
            let mut line = String::new();
            io::stdin().read_line(&mut line).unwrap();
            let line = line.trim();

            println!("Введите подстроку");
            let mut subline = String::new();
            io::stdin().read_line(&mut subline).unwrap();
            let subline = subline.trim();

            println!("{}", if first_task(line, subline) { "Yes" } else { "No" });
        },
        2 => {
            let checkout_input = "qwertyuiopasdfghjklzxcvbnm ";
            let mut line = String::new();

            loop {
                println!("Введите строку");
                line.clear();
                io::stdin().read_line(&mut line).unwrap();
                let line = line.trim();

                if line.chars().all(|c| checkout_input.contains(c)) {
                    break;
                }

                for c in line.chars() {
                    if !checkout_input.contains(c) {
                        println!("Ошибка! Недопустимый символ: '{}'. Повторите ввод:", c);
                        break;
                    }
                }
            }

            println!("{}", if second_task(&line) { "Yes" } else { "No" });
        },
        3 => {
            println!("Введите числа");
            let mut input = String::new();
            io::stdin().read_line(&mut input).unwrap();
            let nums: Vec<i32> = input.split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();

            if nums.is_empty() || nums[0] == 0 {
                println!("Ошибка!Неверный ввод");
                move_flag = false;
                Command::new("code").arg("CPlusPlus.rs").spawn().unwrap();
            } else {
                let mut count = 0;
                let mut prev = nums[0].abs();

                for &num in &nums[1..] {
                    if num.abs() == prev {
                        count += 1;
                    }
                    prev = num.abs();
                }

                println!("Количество чисел равных предыдущему = {}", count);
            }
        },
        _ => {
            println!("Неверный ввод");
            move_flag = false;
            main();
        }
    }

    while move_flag {
        println!("Желаете выйти в меню выбора языка? \n 1 - Yes \n 2 - No");

        let mut choice = String::new();
        io::stdin().read_line(&mut choice).unwrap();
        let choice: i32 = choice.trim().parse().unwrap();

        match choice {
            1 => {
                Command::new("code").arg("/home/nomask776/Laboratory_work_second/main.cpp").spawn().unwrap();
                move_flag = false;
            },
            2 => {
                move_flag = false;
                main();
            },
            _ => println!("Неверный ввод"),
        }
    }
}
