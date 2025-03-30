#include<iostream> 
#include<string>
#include <limits>
#include <cctype>
#include <cmath>
using namespace std;
bool first_task(string line,string subline){
    string double_line = line + line;
    if (line.length() != subline.length()){
        return false;
    }else if(double_line.find(subline) != string::npos){
        return true;
    }else{
        return false;
    }
}
bool second_task(string line){
    string alphabet = "qwertyuiopasdfghjklzxcvbnm";
    if (line.find(" ") != string::npos){
        alphabet += " ";
    }
    for (char symbol : alphabet){
        if (line.find(symbol) == string::npos){
            return false;
        }
    }
    return true;
    
}  
int main(){
    cout << "Введите модуль \n 1 - 1.3 \n 2 - 2.9 \n 3 - 3.19"<<endl;
    int menu;
    cin >> menu;
    cin.ignore(numeric_limits<streamsize>::max(), '\n');;
    enum module{
        first=1,
        second,
        third,
    };
    bool move = true;
    switch (menu)
    {
    case module::first:{
        cout << "Введите строку"<<endl;
        string line,subline;
        getline(cin,line);
        cout << "Введите подстроку"<<endl;
        getline(cin,subline);
        bool function_first = first_task(line,subline);
        if (function_first){
            cout << "Yes"<<endl;
        }else   cout<<"No"<<endl;
        break;
    }
    case module::second:{
        string line;
        string checkout_input = "qwertyuiopasdfghjklzxcvbnm ";
        while (true){
            cout << "Введите строку" << endl;
            getline(cin, line);
            bool valid = true;
            for (char symbol : line) {
                if (checkout_input.find(symbol) == string::npos) {
                    cout << "Ошибка! Недопустимый символ: '" << symbol << "'. Повторите ввод:" << endl;
                    valid=false;
                }
            }
            if (valid){
                break;
            }
        }
        bool function = second_task(line);
        if (function){
            cout << "Yes"<<endl;
        }else   cout<<"No"<<endl;
        break;
    }
    case module::third: {
        cout << "Введите числа"<<endl;
        int number;
        bool first = true;
        int previousnumber;
        int count = 0;
        while (cin >> number){
            if (first){
                previousnumber = abs(number);
                first = false;
            }else{
                if (abs(number) == previousnumber){
                    count ++;
                }
                previousnumber = abs(number);
            }
            if (cin.peek() == '\n'){
                break;
            }
        }
        if (number == 0){
            cout << "Ошибка!Невырный ввод"<<endl;
            move = false;
            system("code CPlusPlus.cpp");;
        }else   cout << "Количество чисел равных предыдущему = " <<count<< endl;
        
        break;
    }
    default:
        cout << "Невверный ввод"<<endl;
        move = false;
        main();
        break;
        
    }
    while (move){
        cout << "Желаете выйти в меню выбора языка? \n 1 - Yes \n 2 - No"<<endl;
        int move_menu;
        cin >> move_menu;
        if (move_menu == 1){
            system("code main.cpp");
            move = false;
        }else if (move_menu ==2){ 
            main();
            move = false;
        }else{
            cout<<"Невверный ввод"<<endl;
        }
    }
    return 0;
}