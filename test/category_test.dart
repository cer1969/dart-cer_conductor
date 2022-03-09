import 'package:cer_conductor/cer_conductor.dart';
import 'package:test/test.dart';

void main() {
  var cate = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0.00340, 'AAAC');

  setUp(() {
    cate = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0.00340, 'AAAC');
    // print("Reset General");
  });

  group('Category', () {
    test('Constructor', () {
      expect(cate.name, 'AAAC (AASC)');
      expect(cate.modelas, greaterThan(0));
      expect(cate.coefexp, greaterThan(0));
      expect(cate.creep, greaterThanOrEqualTo(0));
      expect(cate.alpha, inExclusiveRange(0, 1));
      expect(cate.id, 'AAAC');
      cate = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0.00340);
      expect(cate.id, '');
    });
    test('Constructor values', () {
      expect(() => Category('C', 0, 0.1, 0, 0.1), throwsA(TypeMatcher<ValueException>()));
      expect(() => Category('C', -1, 0.1, 0, 0.1), throwsA(TypeMatcher<ValueException>()));
      expect(() => Category('C', 0.1, 0, 0, 0.1), throwsA(TypeMatcher<ValueException>()));
      expect(() => Category('C', 0.1, -1, 0, 0.1), throwsA(TypeMatcher<ValueException>()));
      expect(() => Category('C', 0.1, 0.1, -1, 0.1), throwsA(TypeMatcher<ValueException>()));
      expect(() => Category('C', 0.1, 0.1, 0, 0), throwsA(TypeMatcher<ValueException>()));
      expect(() => Category('C', 0.1, 0.1, 0, 1), throwsA(TypeMatcher<ValueException>()));
    });
    test('modelas', () {
      expect(() => cate.modelas = 0, throwsA(TypeMatcher<ValueException>()));
      expect(() => cate.modelas = -1, throwsA(TypeMatcher<ValueException>()));
      cate.modelas = 1000;
      expect(cate.modelas, 1000);
    });
    test('coefexp', () {
      expect(() => cate.coefexp = 0, throwsA(TypeMatcher<ValueException>()));
      expect(() => cate.coefexp = -1, throwsA(TypeMatcher<ValueException>()));
      cate.coefexp = 0.1;
      expect(cate.coefexp, 0.1);
    });
    test('creep', () {
      expect(() => cate.creep = -1, throwsA(TypeMatcher<ValueException>()));
      cate.creep = 0;
      expect(cate.creep, 0);
    });
    test('alpha', () {
      expect(() => cate.alpha = 0, throwsA(TypeMatcher<ValueException>()));
      expect(() => cate.alpha = 1, throwsA(TypeMatcher<ValueException>()));
      cate.alpha = 0.1;
      expect(cate.alpha, 0.1);
      cate.alpha = 0.99;
      expect(cate.alpha, 0.99);
    });
  });
}
