#include <iostream>
#include "FileEditor.h"
#include <vector>

using namespace std;

int main() {
    TextFileEditor tfe = TextFileEditor("../text.txt", "Hello World!");
    tfe.UseFileEditor();

    vector<int> vec(10, 1);
    VectorFileEditor vfe = VectorFileEditor("../text2.txt", vec);
    vfe.UseFileEditor();

}
