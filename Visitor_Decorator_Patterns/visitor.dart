void main(List<String> args) {
  BodyPartVisitorSlap bpvs =BodyPartVisitorSlap();
  Hand myHand = Hand();
  bpvs.visit(myHand);
}

abstract class BodyPart {
  late String name;
  void accept(BodyPartVisitor visitor) => visitor.visit(this);
}

abstract class BodyPartVisitor {
  void visit(BodyPart bodyPart);
}

class Hand extends BodyPart {
  String name = 'Hand';
  @override
  void accept(BodyPartVisitor visitor) {
    print('Stop touching my $name!');
  }
}

class BodyPartVisitorSlap extends BodyPartVisitor{
  void visit(BodyPart bp) {bp.accept(this);}
}
