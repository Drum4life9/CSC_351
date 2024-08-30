#include "FileEditor.h"
#include <fstream>
#include <iostream>

//--------------------------FILE EDITOR FUNCTIONS----------------------//
FileEditor::FileEditor(std::string fileName) {
    this->fileName = fileName;
}

void FileEditor::UseFileEditor() {
    OpenFile();
    WriteFile();
    //CloseFile();
}

void FileEditor::OpenFile() {
    fs.open(fileName);
}

void FileEditor::CloseFile() {std::fstream fs;
    fs.close();
}

//-----------We override this in the subclasses----------//
void FileEditor::WriteFile() {std::cout << "stuff";}


//----------------TEXT FILE EDITOR FUNCTIONS-------------//
TextFileEditor::TextFileEditor(std::string fileName, std::string text) : FileEditor(fileName) {
    this->text = text;
}

void TextFileEditor::WriteFile() {
    fs << text << std::endl;
    fs << "I printed some text" << std::endl;
}



//----------------VECTOR (OH YEAAA) FILE EDITOR FUNCTIONS-------------//
VectorFileEditor::VectorFileEditor(std::string fileName, std::vector<int> vector) : FileEditor(fileName) {
    this->vector = vector;
}

void VectorFileEditor::WriteFile() {
    for (int i : vector) {
        fs << i << std::endl;
    }
    fs << "I printed a vector" << std::endl;
}

