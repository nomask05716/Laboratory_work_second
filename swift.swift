import Foundation

// Функция для выполнения системных команд
func runCommand(_ args: String...) {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = args
    
    do {
        try process.run()
        process.waitUntilExit()
    } catch {
        print("Ошибка выполнения команды: \(error)")
    }
}

func firstTask(_ line: String, _ subline: String) -> Bool {
    let doubleLine = line + line
    return line.count == subline.count && doubleLine.contains(subline)
}

func secondTask(_ line: String) -> Bool {
    var alphabet = "qwertyuiopasdfghjklzxcvbnm"
    if line.contains(" ") {
        alphabet += " "
    }
    return alphabet.allSatisfy { line.contains(String($0)) }
}

func main() {
    print("Введите модуль \n 1 - 1.3 \n 2 - 2.9 \n 3 - 3.19")
    
    guard let menuInput = readLine(), let menu = Int(menuInput) else {
        print("Невверный ввод")
        main()
        return
    }

    enum Module: Int {
        case first = 1, second, third
    }

    var move = true

    switch menu {
    case Module.first.rawValue:
        print("Введите строку")
        guard let line = readLine(), !line.isEmpty else { return }
        print("Введите подстроку")
        guard let subline = readLine(), !subline.isEmpty else { return }
        
        print(firstTask(line, subline) ? "Yes" : "No")

    case Module.second.rawValue:
        let allowedChars = Set("qwertyuiopasdfghjklzxcvbnm ")
        var line = ""
        
        while true {
            print("Введите строку")
            guard let input = readLine() else { continue }
            
            if input.allSatisfy({ allowedChars.contains($0) }) {
                line = input
                break
            } else {
                let invalidChars = input.filter { !allowedChars.contains($0) }
                print("Ошибка! Недопустимые символы: \(invalidChars.map { "'\($0)'" }.joined(separator: ", "))")
            }
        }
        
        print(secondTask(line) ? "Yes" : "No")

    case Module.third.rawValue:
        print("Введите числа через пробел")
        guard let input = readLine() else { return }
        let numbers = input.split(separator: " ").compactMap { Int($0) }
        
        if numbers.isEmpty || numbers.contains(0) {
            print("Ошибка! Неверный ввод")
            runCommand("code", "CPlusPlus.cpp")
            move = false
        } else {
            var count = 0
            var prev = abs(numbers[0])
            
            for num in numbers.dropFirst() {
                if abs(num) == prev { count += 1 }
                prev = abs(num)
            }
            print("Количество чисел равных предыдущему = \(count)")
        }

    default:
        print("Невверный ввод")
        move = false
        main()
    }

    while move {
        print("Желаете выйти в меню выбора языка? \n 1 - Yes \n 2 - No")
        guard let choice = readLine(), let option = Int(choice) else {
            print("Невверный ввод")
            continue
        }

        switch option {
        case 1:
            runCommand("code", "/home/nomask776/Laboratory_work_second/main.cpp")
            move = false
        case 2:
            main()
            move = false
        default:
            print("Невверный ввод")
        }
    }
}

main()
