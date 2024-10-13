import 'package:test/test.dart';

void main() {
  group('String', () {
    test('.split() splits the string on the delimiter', () {
      var string = 'foo,bar,baz';
      expect(string.split(','), equals(['foo', 'bar', 'baz']));
    });

    test('.trim() removes surrounding whitespace', () {
      var string = '  foo ';
      expect(string.trim(), equals('foo'));
    });
  });

  group('int', () {
    test('.remainder() returns the remainder of division', () {
      expect(11.remainder(3), equals(2));
    });

    test('.toRadixString() returns a hex string', () {
      expect(11.toRadixString(16), equals('b'));
    });
  });

  var string = "123";

  group("String To Int Conversion Test", () {
    test("Check if string is empty", () {
      expect(string.isNotEmpty, true);
    });

    test("Check conversion of string to integer", () {
      expect(int.parse(string), 123);
    });
  });
}


/*
 * For project 2, I don't think we need to be implementing testing. Testing wouldn't be too hard to implement into the server, and to be honest,
 * I've never though about using testing for these things, but it would actually kinda make my life a lot easier when dealing with DB inputs and stuff.
 * We would need to absolutely heed the book's instructions of not letting the tests be fragile, so we cannot have them depending on low level details
 * such as the GUI or database directly. We can make these tests dependent on the business rules and functions of the code (unit tests deal with functions
 * and with classes), and then we could probabl design tests to control our logic flow
*/
