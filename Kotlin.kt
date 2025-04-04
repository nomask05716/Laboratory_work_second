import java.lang.ProcessBuilder
import kotlin.math.abs

fun first_task(line: String, subline: String): Boolean {
    val double_line = line + line
    return line.length == subline.length && double_line.contains(subline)
}

fun second_task(line: String): Boolean {
    var alphabet = "qwertyuiopasdfghjklzxcvbnm"
    if (line.contains(" ")) {
        alphabet += " "
    }
    for (symbol in alphabet) {
        if (!line.contains(symbol)) {
            return false
        }
    }
    return true
}
enum class Module { FIRST, SECOND, THIRD }
fun main() {
    var move = true
    println("Введите модуль \n 1 - 1.3 \n 2 - 2.9 \n 3 - 3.19")
    val menu = readLine()?.toIntOrNull() ?: 0
    
    
    
    when (menu) {
        Module.FIRST.ordinal + 1 -> {
            println("Введите строку")
            val line = readLine().orEmpty()
            println("Введите подстроку")
            val subline = readLine().orEmpty()
            println(if (first_task(line, subline)) "Yes" else "No")
        }
        Module.SECOND.ordinal + 1 -> {
            val checkout_input = "qwertyuiopasdfghjklzxcvbnm "
            var line: String
            while (true) {
                println("Введите строку")
                line = readLine().orEmpty()
                var valid = true
                for (symbol in line) {
                    if (!checkout_input.contains(symbol.toString(), true)) {
                        println("Ошибка! Недопустимый символ: '$symbol'. Повторите ввод:")
                        valid = false
                    }
                }
                if (valid) break
            }
            println(if (second_task(line)) "Yes" else "No")
        }
        Module.THIRD.ordinal + 1 -> {
            println("Введите числа")
            val input = readLine().orEmpty().trim()
            val numbers = mutableListOf<Int>()
            var hasInvalidInput = false
            var hasZero = false
            
            for (part in input.split("\\s+".toRegex())) {
                val number = part.toIntOrNull()
                when {
                    number == null -> {
                        hasInvalidInput = true
                        break
                    }
                    number == 0 -> {
                        hasZero = true
                        break
                    }
                    else -> numbers.add(number)
                }
            }
            
            when {
                hasInvalidInput || hasZero -> {
                    println("Ошибка! Неверный ввод")
                    move = false
                    ProcessBuilder("code", "/home/nomask776/my-kotlin-debug/src/main/kotlin/Main.kt").start()
                }
                numbers.size < 2 -> {
                    println("Количество чисел равных предыдущему = 0")
                }
                else -> {
                    var count = 0
                    for (i in 1 until numbers.size) {
                        if (abs(numbers[i]) == abs(numbers[i-1])) count++
                    }
                    println("Количество чисел равных предыдущему = $count")
                }
            }
        }
    }
    
    while (move) {
        println("Желаете выйти в меню выбора языка? \n 1 - Yes \n 2 - No")
        when (readLine()?.toIntOrNull()) {
            1 -> {
                ProcessBuilder("code", "/home/nomask776/Laboratory_work_second/main.cpp").start()
                move = false
            }
            2 -> {
                main()
                move = false
            }
            else -> println("Неверный ввод")
        }
    }
}