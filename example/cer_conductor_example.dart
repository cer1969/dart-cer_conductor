import 'package:cer_conductor/cer_conductor.dart';

void main() {
  var cate = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0.00340, 'AAAC');
  var cond = Conductor("AAAC 740,8 MCM FLINT", cate, 25.17, 375.4, 1.035, 11625, 0.089360, 0.052);
  print('Conductor name: ${cond.name}');
  print('Conductor category: ${cond.category.name}');

  var cc = CurrentCalc(cond);
  print('CurrentCalc conductor r25: ${cc.conductor.r25}');
  print('CurrentCalc r a 50°: ${cc.getResistance(50)}');

  var curr = cc.getCurrent(25, 50);
  print('CurrentCalc current 25,50: $curr');

  print('CurrentCalc Ta 50°, 600 A: ${cc.getTa(50, 600)}');
  print('CurrentCalc Tc 25°, 600 A: ${cc.getTc(25, 600)}');

  var cc2 = CurrentCalc.fromData(0.00340, 25.17, 0.089360);
  print(cc2.getTc(25, 600));

  print(cc2.conductor);
}
