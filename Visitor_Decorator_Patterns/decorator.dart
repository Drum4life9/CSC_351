void main(List<String> args) {
  addOperation add = addOperation();
  multiplyOperation mult = multiplyOperation();
  bothOperationDecorator bod =bothOperationDecorator(1, [add, mult]);

  bod.execute();
  bod.printStart();
}

abstract class operationsDecorator {
  late List<operation> operations;
  late int start = 0;
  void execute();
}

abstract class operation {
  int executeOperation(int inp, int base);
}

class addOperation extends operation {
  int executeOperation(int inp, int base) {
    return base + inp;
  }
}

class multiplyOperation extends operation {
  int executeOperation(int inp, int base) {
    return base * inp;
  }
}

class bothOperationDecorator extends operationsDecorator {
  bothOperationDecorator(int s, List<operation> op) {start = s; operations = op;}
  @override
  void execute() {
    for (operation op in operations) {
      start = op.executeOperation(5, start);
    }
  }

  void printStart() {
    print(this.start);
  }
}
