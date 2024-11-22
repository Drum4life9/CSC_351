#include <string>
#include <iostream>
#include <utility>
using namespace std;

//abstract classes
class Banister {
public:
    virtual ~Banister() = default;

    explicit Banister(string desc) : desc(std::move(desc)){};
    virtual void printDesc() {}

protected:
    string desc;
};

class Staircase {
public:
    virtual ~Staircase() = default;

    explicit Staircase(string desc)  : desc(std::move(desc)){};
    virtual void printDesc() {}

protected:
    string desc;
};

//concrete classes

class ModernBanister final : public Banister {
public:
    explicit ModernBanister(const string& desc) : Banister(desc) {};
    void printDesc() override {
        cout << this->desc << endl;
    }
    ~ModernBanister() override = default;
};

class NeoBanister final : public Banister {
public:
    explicit NeoBanister(const string& desc) : Banister(desc) {};
    void printDesc() override {
        cout << this->desc << endl;
    }
    ~NeoBanister() override = default;
};

class ModernStaircase final : public Staircase {
public:
    explicit ModernStaircase(const string& desc) : Staircase(desc) {};
    void printDesc() override {
        cout << this->desc << endl;
    }
    ~ModernStaircase() override = default;
};

class NeoStaircase final : public Staircase {
public:
    explicit NeoStaircase(const string& desc) : Staircase(desc) {};
    void printDesc() override {
        cout << this->desc << endl;
    }
    ~NeoStaircase() override = default;
};


//factory classes


class AbstractFactory {
public:
    virtual ~AbstractFactory() = default;

    [[nodiscard]] virtual Banister *CreateBanister() const = 0;
    [[nodiscard]] virtual Staircase *CreateStaircase() const = 0;
};

class ConcreteNeoFactory final : public AbstractFactory {
    public:
    [[nodiscard]] Banister *CreateBanister() const override {
        return new NeoBanister("I\'m a Neo Banister!");
    }
    [[nodiscard]] Staircase *CreateStaircase() const override {
        return new NeoStaircase("I\'m a Neo Staircase!");
    }
    ~ConcreteNeoFactory() override = default;
};

class ConcreteModernFactory final : public AbstractFactory {
    public:
    [[nodiscard]] Banister *CreateBanister() const override {
        return new ModernBanister("I\'m a Modern Banister!");
    }
    [[nodiscard]] Staircase *CreateStaircase() const override {
        return new ModernStaircase("I\'m a Modern Staircase!");
    }
    ~ConcreteModernFactory() override = default;
};