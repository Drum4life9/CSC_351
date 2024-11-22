#include <iostream>
#include <thread>
#include <mutex>

using namespace std;

std::mutex mut;


std::thread PlaceOrder(const std::string &item)
{
    mut.lock();
    cout << "Order placed: " << item << endl;
    const int time = std::rand() * 3000;
    std::this_thread::sleep_for(std::chrono::milliseconds(time));
    cout << "Order completed: " << item << endl;

    mut.unlock();
}

int main() {
    std::thread t1(PlaceOrder("Eggs"));
    std::thread t2(PlaceOrder("Ham"));
    std::thread t3(PlaceOrder("Bread"));

    t1.join();
    t2.join();
    t3.join();

}