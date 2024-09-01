//
// Created by b1sth3be5t on 9/1/24.
//

#include "Strategy.h"

#include <iostream>
#include <ostream>

using namespace std;

void Strategy::solve_Rubiks_cube() {}

void F2L_Strategy::solve_Rubiks_cube() {
    cout << "First I solve the White cross" << endl;
    cout << "Then I use F2L to get the first 2 layers in place" << endl;
    cout << "I put all the yellow edges and corners uprights" << endl;
    cout << "I orient the edges and corners correctly" << endl;
    cout << "The cube is now solved!!" << endl;
}

void White_Cross_Strategy::solve_Rubiks_cube() {
    cout << "First I solve the White cross" << endl;
    cout << "Then I put the white corners in place" << endl;
    cout << "Then the f2l edges go into place" << endl;
    cout << "Then I solve the yellow cross" << endl;
    cout << "The yellow edges now go upwards" << endl;
    cout << "I put the yellow corners in place" << endl;
    cout << "Finally, I put the yellow edges in place" << endl;
    cout << "The cube is now solved!!" << endl;
}

StrategySelector::StrategySelector() = default;

void StrategySelector::setStrategy(Strategy const &s) {
    this->strategy = s;
}

void StrategySelector::executeStrategy() {
    this->strategy.solve_Rubiks_cube();
}


