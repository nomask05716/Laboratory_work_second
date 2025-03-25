using System;
using System.Collections.Generic;
using System.Diagnostics;

class Program
{
    static bool FirstTask(string line, string subline)
    {
        string doubleLine = line + line;
        return line.Length == subline.Length && doubleLine.Contains(subline);
    }

    static bool SecondTask(string line)
    {
        var requiredChars = new HashSet<char>("qwertyuiopasdfghjklzxcvbnm");
        if (line.Contains(" ")) requiredChars.Add(' ');
        
        var lineChars = new HashSet<char>(line.ToLower());
        return requiredChars.IsSubsetOf(lineChars);
    }

    static void Main()
    {
        while (true)
        {
            Console.WriteLine("Введите модуль \n 1 - 1.3 \n 2 - 2.9 \n 3 - 3.19 ");
            
            if (!int.TryParse(Console.ReadLine(), out int menu))
            {
                Console.WriteLine("Ошибка ввода!");
                continue;
            }

            bool move = true;
            switch (menu)
            {
                case 1:
                {
                    Console.WriteLine("Введите строку");
                    string line = Console.ReadLine() ?? "";
                    Console.WriteLine("Введите подстроку");
                    string subline = Console.ReadLine() ?? "";
                    Console.WriteLine(FirstTask(line, subline) ? "Yes" : "No");
                    break;
                }
                
                case 2:
                {
                    const string validChars = "qwertyuiopasdfghjklzxcvbnm ";
                    string line;
                    while (true)
                    {
                        Console.WriteLine("Введите строку");
                        line = Console.ReadLine()?.ToLower() ?? "";
                        bool valid = true;
                        foreach (char symbol in line)
                        {
                            if (!validChars.Contains(symbol))
                            {
                                Console.WriteLine($"Ошибка! Недопустимый символ: '{symbol}'");
                                valid = false;
                            }
                        }
                        if (valid) break;
                    }
                    Console.WriteLine(SecondTask(line) ? "Yes" : "No");
                    break;
                }
                
                case 3:
                {
                    Console.WriteLine("Введите числа");
                    string input = Console.ReadLine() + " "; // Добавляем пробел для обработки последнего числа
                    int currentNumber = 0;
                    bool isNegative = false;
                    bool isBuildingNumber = false;
                    bool first = true;
                    int previousNumber = 0;
                    int count = 0;
                    bool lastIsZero = false;
                    bool error = false;

                    foreach (char c in input)
                    {
                        if (char.IsDigit(c))
                        {
                            currentNumber = currentNumber * 10 + (c - '0');
                            isBuildingNumber = true;
                        }
                        else if (c == '-' && !isBuildingNumber)
                        {
                            isNegative = true;
                        }
                        else if (c == ' ' || c == '\t' || c == '\n')
                        {
                            if (isBuildingNumber)
                            {
                                if (isNegative)
                                    currentNumber = -currentNumber;
                    
                                int num = currentNumber;
                    
                                if (num == 0)
                                    lastIsZero = true;
                                else
                                    lastIsZero = false;

                                if (first)
                                {
                                    previousNumber = Math.Abs(num);
                                    first = false;
                                }
                                else
                                {
                                    if (Math.Abs(num) == previousNumber)
                                        count++;
                                    previousNumber = Math.Abs(num);
                                }

                                currentNumber = 0;
                                isNegative = false;
                                isBuildingNumber = false;
                            }
                        }
                        else
                        {
                            error = true;
                            break;
                        }
                    }

                    if (error || lastIsZero)
                        Console.WriteLine("Ошибка! Неверный ввод");    
                    else
                        Console.WriteLine($"Количество чисел равных предыдущему = {count}");
                    break;
                }
                
                default:
                {

                    Console.WriteLine("Неверный ввод!");
                    move = false; 
                    Process.Start("./bin/Release/net9.0/linux-x64/CSharp");
                    break;
                }
            }

            if (move)
            {
                Console.WriteLine("\nВернуться в меню? (1 - Да, 0 - Нет)");
                if (int.TryParse(Console.ReadLine(), out int choice)){
                    if (choice == 1){
                        Process.Start("code", "/home/nomask786/Laboratory_work_second/main.cpp");
                    }
                }
                else if (choice == 0)
                    {
                        Process.Start("./bin/Release/net9.0/linux-x64/CSharp");
                    }
            }
            
            Console.Clear();
        }
    }
}