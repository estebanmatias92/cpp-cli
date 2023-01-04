#include <iostream>
#include <string>

#include "app.hpp"
#include "e92math.hpp"
#include "cppversion.hpp"

using namespace std;

/*
    Start the app from this function
*/
void e92app::run() {
    cout << endl
         << "Version: " << GetCppVersion() << endl;
         
    string msg = "\nHello World!!!\n";

    cout << msg;
    cout << "Caesar Cipher: " e92math::CaesarCipher(msg) << endl;
}
