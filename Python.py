import sys
import os
def first_task(line, subline):
    return len(line) == len(subline) and subline in (line + line)
def second_task(line):
    required = set("qwertyuiopasdfghjklzxcvbnm")
    line_set = set(line.lower())
    return required.issubset(line_set) and ' ' not in required
def main():
    script_name = sys.argv[0]  # Получаем имя текущего скрипта
    while True:
        try:
            print("Выберите модуль:\n1 - 1.3\n2 - 2.9\n3 - 3.19")
            menu = int(input())
            if menu == 1:
                line = input("Введите строку: ")
                subline = input("Введите подстроку: ")
                print("Yes" if first_task(line, subline) else "No")
            elif menu == 2:
                while True:
                    line = input("Введите строку: ")
                    if all(c in "qwertyuiopasdfghjklzxcvbnm" for c in line):
                        break
                    print("Ошибка! Недопустимые символы. Повторите ввод.")
                print("Yes" if second_task(line) else "No")
            elif menu == 3:
                while True:
                    print("Введите числа через пробел:")
                    input_data = input().strip()
                    valid = True
                    numbers = []
                    for part in input_data.split():
                        if not part.lstrip('-').isdigit():
                            valid = False
                            break
                        numbers.append(int(part))
                    if not valid or len(numbers) < 2:
                        print("Ошибка! Введите только числа (минимум 2), разделенные пробелами")
                        continue
                    else:
                        break  
                count = 0
                prev = abs(numbers[0])
                for num in numbers[1:]:
                    if abs(num) == prev:
                        count += 1
                    prev = abs(num)
                print(f"Количество чисел равных предыдущему: {count}")
                move = True
            print("\nВернуться в главное меню?\n1 - Да\n2 - Нет")
            if int(input()) == 1:
                os.system("code /home/nomask786/Laboratory_work_second/main.cpp")
            else:
                os.system(f"python {script_name}")
            return

        except ValueError:
            print("Ошибка ввода! Попробуйте снова\n")
            os.system(f"python {script_name}")
            return
if __name__ == "__main__":
    main()