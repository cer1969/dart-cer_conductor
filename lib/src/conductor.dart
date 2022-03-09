// CRISTIAN ECHEVERRÍA RABÍ

import 'category.dart';

//------------------------------------------------------------------------------

class Conductor {
  /*
	Container for conductor characteristics
	name     : Name of conductor
	category : Category instance
	diameter : Diameter [mm]
	area     : Cross section area [mm2]
	weight   : Weight per unit [kg/m]
	strength : Rated strength [kg]
	r25.     : Resistance at 25°C [Ohm/km]
	hcap     : Heat capacity [kcal/(ft*°C)]
	idx      : Database key
	*/
  String name = "NONE";
  Category category = categoryNONE;
  double diameter = 0;
  double area = 0;
  double weight = 0;
  double strength = 0;
  double r25 = 0;
  double hcap = 0;
  String id = "";

  Conductor(this.name, this.category, this.diameter, this.area, this.weight, this.strength,
      this.r25, this.hcap,
      [this.id = ""]);

  Conductor.none();

  Conductor.forCurrent(this.category, this.diameter, this.r25, {String name = "", String id = ""}) {
    name = name;
    id = id;
  }

  String getPretyValues([int level = 0]) {
    var n1 = " " * (4 * level);
    var n2 = " " * (4 * level + 4);
    return [
      n1 + "Conductor =>",
      n2 + "name: $name",
      category.getPretyValues(level + 1),
      n2 + "diameter: $diameter",
      n2 + "area: $area",
      n2 + "weight: $weight",
      n2 + "strength: $strength",
      n2 + "r25: $r25",
      n2 + "hcap: $hcap",
      n2 + "id: $id",
    ].join("\n");
  }

  @override
  String toString() {
    return getPretyValues();
  }

  // Checkers
  // void checkDiameter() => check(_diameter).gt(0);
  // void checkArea() => check(_area).gt(0);
  // void checkWeight() => check(_weight).gt(0);

  // Getters & Setters
  // double get diameter => _diameter;
  // set diameter(double v) {
  //   _diameter = v;
  //   checkDiameter();
  // }

  // double get area => _area;
  // set area(double v) {
  //   _area = v;
  //   checkArea();
  // }

  // double get weight => _weight;
  // set weight(double v) {
  //   _weight = v;
  //   checkWeight();
  // }
}

//------------------------------------------------------------------------------
// Conductor instances to use as constants

final conductorNONE = Conductor.none();
