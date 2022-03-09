import 'package:cer_conductor/cer_conductor.dart';
import 'package:test/test.dart';

void main() {
  var cate = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0.00340, 'AAAC');
  var cond = Conductor("AAAC 740,8 MCM FLINT", cate, 25.17, 375.4, 1.035, 11625, 0.089360, 0.052);

  setUp(() {
    cate = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0.00340, 'AAAC');
    cond = Conductor("AAAC 740,8 MCM FLINT", cate, 25.17, 375.4, 1.035, 11625, 0.089360, 0.052);
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

  // group('Constructors', () {
  //   test('Category', () {
  //     expect(cate.id, 'AAAC');
  //     cate = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0.00340);
  //     expect(cate.id, '');
  //   });
  //   test('Conductor', () {
  //     expect(cond.id, '');
  //     expect(cond.category, cate);
  //     cond = Conductor("AAAC 740,8 MCM FLINT", cate, 25.17, 0, 0, 0, 0.089360, 0, "X");
  //     expect(cond.id, 'X');
  //   });
  // });

  // group('CurrentCalc', () {
  //   CurrentCalc cc1;
  //   Category cat1, cat2;
  //   Conductor cond1, cond2;

  //   var cc = CurrentCalc(cond);
  //   setUp(() {
  //     cc = CurrentCalc(cond);
  //     print("Reset CurrentCalc");
  //   });

  //   test('conductor r25 > 0', () {
  //     expect(cc.conductor.r25, greaterThan(0));
  //     cond.r25 = 0;
  //     expect(() => cc = CurrentCalc(cond), throwsA(TypeMatcher<ValueException>()));
  //     cond.r25 = -1;
  //     expect(() => cc = CurrentCalc(cond), throwsA(TypeMatcher<ValueException>()));
  //   });
  //   test('conductor diameter > 0', () {
  //     expect(cc.conductor.diameter, greaterThan(0));
  //     cond.diameter = 0;
  //     expect(() => cc = CurrentCalc(cond), throwsA(TypeMatcher<ValueException>()));
  //     cond.diameter = -1;
  //     expect(() => cc = CurrentCalc(cond), throwsA(TypeMatcher<ValueException>()));
  //   });
  //   test('category 0 < alpha < 1', () {
  //     expect(cc.conductor.category.alpha, inExclusiveRange(0, 1));
  //     cate.alpha = 0;
  //     print(cc.conductor.category.alpha);
  //     // expect(() => cc1 = CurrentCalc(cond1), throwsA(TypeMatcher<ValueException>()));

  //     cat1 = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0, 'AAAC');
  //     cat2 = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 1, 'AAAC');
  //     cond1 = Conductor("AAAC 740,8 MCM FLINT", cat1, 25.17, 0, 0, 0, 0.089360, 0);
  //     cond2 = Conductor("AAAC 740,8 MCM FLINT", cat2, 25.17, 0, 0, 0, 0.089360, 0);
  //     expect(() => cc1 = CurrentCalc(cond1), throwsA(TypeMatcher<ValueException>()));
  //     expect(() => cc1 = CurrentCalc(cond2), throwsA(TypeMatcher<ValueException>()));
  //   });

  //   test('altitude >= 0', () {
  //     expect(() => cc.altitude = -100, throwsA(TypeMatcher<ValueException>()));
  //   });
  // });
}
