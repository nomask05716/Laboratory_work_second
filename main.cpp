#include<iostream>
using namespace std;
int main(){
    cout << "Введите ЯП \n 1 - С++ \n 2 - Kotlin \n 3 - C# \n 4 - PHP \n 5 - Rust \n 6 - Go (Goland) \n 7 - Typescript \n 8 - Swift \n 9 - JavaScript \n 10 - Python \n 11 - Java \n 12 - Ruby"<<endl;
    int menu_language;
    cin >> menu_language;
    enum language{
        CPlusPlus = 1,
        Kotlin,
        cSharp,
        PHP,
        Rust,
        Go,
        Typescript,
        Swift,
        JavaScript,
        Python,
        Java,
        Ruby,
    };
    switch (menu_language)
    {
    case language::CPlusPlus :{
        system("code CPlusPlus.cpp");
        break;
    case language::Python: {
        system("code Python.py");
        break;
    }
    case language::cSharp: {
        system("code /home/nomask776/CSharp");
        break;
    }
    case language::Typescript: {
        system("code /home/nomask776/Typescript");
        break;
    }
    case language::JavaScript: {
        system("code /home/nomask776/Javascript");
        break;
    }
    case language::Ruby:{
        system("code /home/nomask776/ruby");
        break;
    }
    case language::Kotlin: {
        system("code /home/nomask776/my-kotlin-debug");
        break;
    }
    case language::Go:{
        system("code /home/nomask776/go");
        break;
    }
    }
    default:
    cout << "Неверный ввод"<<endl;
        system("code main.cpp");
        break;
    }
}