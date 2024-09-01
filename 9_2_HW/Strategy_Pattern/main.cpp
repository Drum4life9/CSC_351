#include <iostream>

#include "Strategy.h"

int main()
{
    //Executes F2L Strategy for solving Rubik's cube
    auto ss = StrategySelector();
    ss.setStrategy(F2L_Strategy());
    ss.executeStrategy();


    //Executes White cross Strategy for solving Rubik's cube
    ss.setStrategy(White_Cross_Strategy());
    ss.executeStrategy();
}
