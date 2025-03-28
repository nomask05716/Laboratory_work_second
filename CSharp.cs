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
                        line = Console.ReadLine()?? "";
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
                    Console.Write("\nВведите числа через пробел \n");
                    string input = (Console.ReadLine() ?? "") + " ";
                    int currentNumber = 0;
                    bool isNegative = false;
                    bool isBuildingNumber = false;
                    bool first = true;
                    int previousNumber = 0;
                    int count = 0;
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
                        else if (char.IsWhiteSpace(c))
                        {
                            if (isBuildingNumber || isNegative)
                            {
                                if (isNegative && !isBuildingNumber)
                                {
                                    error = true;
                                    break;
                                }

                                if (isNegative)
                                    currentNumber = -currentNumber;

                                if (first)
                                {
                                    previousNumber = Math.Abs(currentNumber);
                                    first = false;
                                }
                                else
                                {
                                    if (Math.Abs(currentNumber) == previousNumber)
                                        count++;
                                    previousNumber = Math.Abs(currentNumber);
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

                    if (error || first)
                    {
                        Console.WriteLine("\nОшибка ввода!");
                    }
                    else
                    {
                        Console.WriteLine($"\nКоличество чисел, равных по модулю предыдущему: {count}\n");
                    }
                    break;
                }
                
                default:
                {

                    Console.WriteLine("Неверный ввод!");
                    move = false; 
                    Main();
                    break;
                }
            }

            if (move)
            {
                Console.WriteLine("\nВернуться в меню? (1 - Да, 2 - Нет)");
                if (int.TryParse(Console.ReadLine(), out int choice))
                {
                    if (choice == 1)
                    {
                        Process.Start("code", "/home/nomask776/Laboratory_work_second/main.cpp");
                        move = false;
                        break;
                    }
                    else if (choice == 2)
                    {
                        move = false;
                        Main();
                        break;
                    }
                    else
                    {
                        Console.WriteLine("Неверный ввод!");
                    }
                }   
                else
                {
                    Console.WriteLine("Неверный ввод! Введите число");
                }     
            }
            Console.Clear();
        }
    }
}
