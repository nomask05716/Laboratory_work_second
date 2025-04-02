import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static boolean firstTask(String line, String subline) {
        String doubleLine = line + line;
        if (line.length() != subline.length()) {
            return false;
        } else return doubleLine.contains(subline);
    }

    public static boolean secondTask(String line) {
        String alphabet = "qwertyuiopasdfghjklzxcvbnm";
        if (line.contains(" ")) {
            alphabet += " ";
        }
        for (int i = 0; i < alphabet.length(); i++) {
            char symbol = alphabet.charAt(i);
            if (line.indexOf(symbol) == -1) {
                return false;
            }
        }
        return true;
    }

    public static void systemCall(String command) {
        try {
            Runtime.getRuntime().exec(command);
        } catch (IOException e) {
            System.err.println("System call failed: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.println("Введите модуль \n 1 - 1.3 \n 2 - 2.9 \n 3 - 3.19");
            int menu = scanner.nextInt();
            scanner.nextLine(); 
            
            final int FIRST = 1;
            final int SECOND = 2;
            final int THIRD = 3;
            
            boolean move = true;
            
            switch (menu) {
                case FIRST -> {
                    System.out.println("Введите строку");
                    String line = scanner.nextLine();
                    System.out.println("Введите подстроку");
                    String subline = scanner.nextLine();
                    
                    boolean functionFirst = firstTask(line, subline);
                    System.out.println(functionFirst ? "Yes" : "No");
                }
                
                case SECOND -> {
                    String line;
                    String checkoutInput = "qwertyuiopasdfghjklzxcvbnm ";
                    
                    while (true) {
                        System.out.println("Введите строку");
                        line = scanner.nextLine();
                        boolean valid = true;
                        
                        for (int i = 0; i < line.length(); i++) {
                            char symbol = line.charAt(i);
                            if (checkoutInput.indexOf(symbol) == -1) {
                                System.out.println("Ошибка! Недопустимый символ: '" + symbol + "'. Повторите ввод:");
                                valid = false;
                                break;
                            }
                        }
                        
                        if (valid) break;
                    }
                    
                    boolean function = secondTask(line);
                    System.out.println(function ? "Yes" : "No");
                }
                
                case THIRD -> {
                    System.out.println("Введите числа через пробел:");
                    String inputLine = scanner.nextLine();
                    try (Scanner lineScanner = new Scanner(inputLine)) {
                        int previousNumber = 0;
                        int count = 0;
                        boolean first = true;
                        
                        while (lineScanner.hasNextInt()) {
                            int number = lineScanner.nextInt();
                            if (first) {
                                previousNumber = Math.abs(number);
                                first = false;
                            } else {
                                if (Math.abs(number) == previousNumber) {
                                    count++;
                                }
                                previousNumber = Math.abs(number);
                            }
                        }
                        
                        if (first) {
                            System.out.println("Ошибка! Неверный ввод");
                            move = false;
                            systemCall("code Main.java");
                        } else {
                            System.out.println("Количество чисел равных предыдущему = " + count);
                        }
                    }
                }

                
                default -> {
                    System.out.println("Неверный ввод");
                    move = false;
                    main(args);
                }
            }
            
            while (move) {
                System.out.println("Желаете выйти в меню выбора языка? \n 1 - Yes \n 2 - No");
                if (scanner.hasNextInt()) {
                    int moveMenu = scanner.nextInt();
                    scanner.nextLine(); 
                    
                    switch (moveMenu) {
                        case 1 -> {
                            systemCall("code /home/nomask776/Laboratory_work_second/main.cpp");
                            move = false;
                        }
                        case 2 -> {
                            main(args);
                            move = false;
                        }
                        default -> System.out.println("Неверный ввод");
                    }
                } else {
                    System.out.println("Неверный ввод");
                    scanner.nextLine(); 
                }
            }
        }
    }
}