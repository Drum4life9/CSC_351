#include <iostream>
#include "abstract_factory.cpp"

using namespace std;

void ClientCode(const AbstractFactory &factory) {
     Banister *product_a = factory.CreateBanister();
    Staircase *product_b = factory.CreateStaircase();
    product_a->printDesc();
    product_b->printDesc();
    delete product_a;
    delete product_b;
};


class Singleton {
public:
    // Static method to access the singleton instance
    static Singleton& getInstance()
    {
        // If the instance doesn't exist, create it
        if (!instance) {
            instance = new Singleton();
        }
        return *instance;
    }

    // Public method to perform some operation
    void someOperation()
    {
        std::cout
            << "Singleton is performing some operation."
            << std::endl;
    }

    // Delete the copy constructor and assignment operator
    Singleton(const Singleton&) = delete;
    Singleton& operator=(const Singleton&) = delete;

private:
    // Private constructor to prevent external instantiation
    Singleton()
    {
        std::cout << "Singleton instance created."
                << std::endl;
    }

    // Private destructor to prevent external deletion
    ~Singleton()
    {
        std::cout << "Singleton instance destroyed."
                << std::endl;
    }

    // Private static instance variable
    static Singleton* instance;
};

// Initialize the static instance variable to nullptr
Singleton* Singleton::instance = nullptr;


int main() {
    cout << "Client: Testing client code with the Neo factory type:\n";
    const auto *f1 = new ConcreteNeoFactory();
    ClientCode(*f1);
    delete f1;
    cout << endl;
    cout << "Client: Testing the same client code with the Modern factory type:\n";
    const auto *f2 = new ConcreteModernFactory();
    ClientCode(*f2);
    delete f2;

    cout << "-----------------------------------------Singleton Code--------------------------------------------------" << endl;

    Singleton& singleton = Singleton::getInstance();

    // Use the Singleton instance
    singleton.someOperation();


    return 0;
}


