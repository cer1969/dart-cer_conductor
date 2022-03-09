// CRISTIAN ECHEVERRÍA RABÍ

import 'interfaces.dart';
import 'checker.dart';

//------------------------------------------------------------------------------

class Category extends PrettyPrint {
  /*
	Represents a category of conductors with similar characteristics
	name    : Name of conductor category
	modelas : Modulus of elasticity [kg/mm2]
	coefexp : Coefficient of Thermal Expansion [1/°C]
	creep   : Creep [°C]
	alpha   : Temperature coefficient of resistance [1/°C]
	idx     : Database key
	*/
  String name = "NONE";
  double _modelas = 0.1;
  double _coefexp = 0.1;
  double _creep = 0;
  double _alpha = 0.1;
  String id = "";

  Category(this.name, this._modelas, this._coefexp, this._creep, this._alpha, [this.id = ""]) {
    checkModelas();
    checkCoefexp();
    checkCreep();
    checkCreep();
    checkAlpha();
  }

  Category.none();

  Category.forCurrent(this._alpha, {String name = "", String id = ""}) {
    checkAlpha();
    name = name;
    id = id;
  }

  // PretyPrint
  String getTitle() => "Category =>";
  List getData() => [
        "name: $name",
        "modelas: $_modelas",
        "coefexp: $_coefexp",
        "creep: $_creep",
        "alpha: $_alpha",
        "id: $id"
      ];

  // Checkers
  void checkModelas() => check(_modelas).gt(0);
  void checkCoefexp() => check(_coefexp).gt(0);
  void checkCreep() => check(_creep).ge(0);
  void checkAlpha() => check(_alpha).gt(0).lt(1);

  // Getters & Setters
  double get modelas => _modelas;
  set modelas(double v) {
    _modelas = v;
    checkModelas();
  }

  double get coefexp => _coefexp;
  set coefexp(double v) {
    _coefexp = v;
    checkCoefexp();
  }

  double get creep => _creep;
  set creep(double v) {
    _creep = v;
    checkCreep();
  }

  double get alpha => _alpha;
  set alpha(double v) {
    _alpha = v;
    checkAlpha();
  }
}

//------------------------------------------------------------------------------
// Category instances to use as constants

final categoryNONE = Category.none();
final categoryCU = Category("COPPER", 12000, 0.0000169, 0, 0.00374, 'CU');
final categoryAAAC = Category('AAAC (AASC)', 6450.0, 0.0000230, 20.0, 0.00340, 'AAAC');
final categoryACAR = Category('ACAR', 6450.0, 0.0000250, 20.0, 0.00385, 'ACAR');
final categoryACSR = Category('ACSR', 8000.0, 0.0000191, 20.0, 0.00395, 'ACSR');
final categoryAAC = Category('ALUMINUM', 5600.0, 0.0000230, 20.0, 0.00395, 'AAC');
final categoryCUWELD = Category('COPPERWELD', 16200.0, 0.0000130, 0.0, 0.00380, 'CUWELD');
final categoryAASC = categoryAAAC;
final categoryALL = categoryAAC;
