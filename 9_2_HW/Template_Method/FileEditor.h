#include <string>
#include <fstream>
#include <vector>

#ifndef TEMPLATE_METHOD_FILEEDITOR_H
#define TEMPLATE_METHOD_FILEEDITOR_H


class FileEditor {
public:
    FileEditor(std::string fileName);
    void UseFileEditor();

protected:
    std::fstream fs;

    virtual void OpenFile();
    virtual void WriteFile();
    virtual void CloseFile();

private:
    std::string fileName;
};


class TextFileEditor : public FileEditor{
public:
    TextFileEditor(std::string fileName, std::string text);
protected:
    void WriteFile() override;
private:
    std::string text;
};

class VectorFileEditor : public FileEditor{
public:
    VectorFileEditor(std::string fileName, std::vector<int> vector);
protected:
    void WriteFile() override;
private:
    std::vector<int> vector;
};

#endif //TEMPLATE_METHOD_FILEEDITOR_H
