//
// Created by b1sth3be5t on 9/1/24.
//

#ifndef STRATEGY_H
#define STRATEGY_H



class Strategy {
public:
    virtual ~Strategy() = default;

    void virtual solve_Rubiks_cube();
};

class F2L_Strategy : public Strategy {
public:
    ~F2L_Strategy() override = default;
    void solve_Rubiks_cube() override;
};

class White_Cross_Strategy : public Strategy {
public:
    ~White_Cross_Strategy() override = default;
    void solve_Rubiks_cube() override;
};


class StrategySelector  {
public:
    StrategySelector();

    void setStrategy(Strategy const& s);
    void executeStrategy();

private:
    Strategy strategy;
};



#endif //STRATEGY_H
