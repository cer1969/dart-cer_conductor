// CRISTIAN ECHEVERRÍA RABÍ

import 'dart:math';

import 'constants.dart';
import 'checker.dart';
import 'category.dart';
import 'conductor.dart';

//------------------------------------------------------------------------------

class CurrentCalc {
  /*
	Object to calculate conductor current and temperatures.

	Read-write properties
  conductor   : Conductor instance
	altitude    : Altitude [m] = 300.0
	airVelocity : Velocity of air stream [ft/seg] =   2.0
	sunEffect   : Sun effect factor (0 to 1) = 1.0
	emissivity  : Emissivity (0 to 1) = 0.5
	formula     : Define formula for current calculation = CF_IEEE
	deltaTemp   : Temperature difference to determine equality [°C] = 0.0001
	*/
  Conductor conductor = conductorNONE;
  double _altitude = 300;
  double _airVelocity = 2;
  double _sunEffect = 1;
  double _emissivity = 0.5;
  String _formula = formulaIEEE;
  double _deltaTemp = 0.0001;

  CurrentCalc(this.conductor);

  CurrentCalc.fromData(double alpha, double diameter, double r25) {
    var cate = Category.forCurrent(alpha);
    var cond = Conductor.forCurrent(cate, diameter, r25);
    conductor = cond;
  }

  // Checkers
  void checkConductor() {
    check(conductor.r25).gt(0);
    check(conductor.diameter).gt(0);
    check(conductor.category.alpha).gt(0).lt(1);
  }

  // Getters & Setters
  double get altitude => _altitude;
  set altitude(double value) {
    check(value).ge(0);
    _altitude = value;
  }

  double get airVelocity => _airVelocity;
  set airVelocity(double value) {
    check(value).ge(0);
    _airVelocity = value;
  }

  double get sunEffect => _sunEffect;
  set sunEffect(double value) {
    check(value).ge(0).le(1);
    _sunEffect = value;
  }

  double get emissivity => _emissivity;
  set emissivity(double value) {
    check(value).ge(0).le(1);
    _emissivity = value;
  }

  String get formula => _formula;
  set formula(String value) {
    checkStr(value).isIn([formulaCLASSIC, formulaIEEE]);
    _formula = value;
  }

  double get deltaTemp => _deltaTemp;
  set deltaTemp(double value) {
    check(value).gt(0);
    _deltaTemp = value;
  }

  // Methods

  double _getResistanceNoCheck(double tc) {
    /*
  	getResistance sin conductor check.
    Métodos iterativos pueden llamar checkConductor solo una vez
  	*/
    check(tc).ge(tcMIN).le(tcMAX);
    return conductor.r25 * (1 + conductor.category.alpha * (tc - 25));
  }

  double getResistance(double tc) {
    /*
  	Returns resistance [Ohm/km]
  	tc : Conductor temperature [°C]
  	*/
    checkConductor();
    return _getResistanceNoCheck(tc);
  }

  double _getCurrentNoCheck(double ta, double tc) {
    /*
  	getconductor sin conductor check.
    Métodos iterativos pueden llamar checkConductor solo una vez
  	*/
    check(ta).ge(taMIN).le(taMAX);
    check(tc).ge(tcMIN).le(tcMAX);

    if (ta >= tc) {
      return 0;
    }

    var D = conductor.diameter / 25.4; // Diámetro en pulgadas
    var pb = pow(10, 1.880813592 - _altitude / 18336); // Presión barométrica en cmHg
    var V = _airVelocity * 3600; // Vel. viento en pies/hora
    var rc = _getResistanceNoCheck(tc) * 0.0003048; // Resistencia en ohm/pies
    var tm = 0.5 * (tc + ta); // Temperatura media
    var rf = 0.2901577 * pb / (273 + tm); // Densidad rel.aire ¿lb/ft^3?
    var uf = 0.04165 + 0.000111 * tm; // Viscosidad abs. aire ¿lb/(ft x hora)
    var kf = 0.00739 + 0.0000227 * tm; // Coef. conductividad term. aire [Watt/(ft x °C)]
    var qc = 0.283 * sqrt(rf) * pow(D, 0.75) * pow(tc - ta, 1.25); // watt/ft

    if (V != 0) {
      var factor = D * rf * V / uf;
      var qc1 = 0.1695 * kf * (tc - ta) * pow(factor, 0.6);
      var qc2 = kf * (tc - ta) * (1.01 + 0.371 * pow(factor, 0.52));
      if (_formula == formulaIEEE) {
        // IEEE criteria
        qc = max(qc, qc1);
        qc = max(qc, qc2);
      } else {
        // CLASSIC criteria
        if (factor < 12000) {
          qc = qc2;
        } else {
          qc = qc1;
        }
      }
    }
    var lk = pow((tc + 273) / 100, 4);
    var mk = pow((ta + 273) / 100, 4);
    var qr = 0.138 * D * _emissivity * (lk - mk);
    var qs = 3.87 * D * _sunEffect;

    if ((qc + qr) < qs) {
      return 0;
    } else {
      return sqrt((qc + qr - qs) / rc);
    }
  }

  double getCurrent(double ta, double tc) {
    /*
  	Returns current [ampere]
  	ta : Ambient temperature [°C]
  	tc : Conductor temperature [°C]
  	*/
    checkConductor();
    return _getCurrentNoCheck(ta, tc);
  }

  double getTc(double ta, double ic) {
    /*
  	Returns conductor temperature [ampere]
  	ta : Ambient temperature [°C]
  	ic : Current [ampere]
  	*/
    checkConductor();
    check(ta).ge(taMIN).le(taMAX);

    var imin = 0;
    var imax = _getCurrentNoCheck(ta, tcMAX);
    check(ic).ge(imin).le(imax); // Ensure ta <= Tc <= TC_MAX

    var tmin = ta;
    var tmax = tcMAX;
    var cuenta = 0;

    double tmed = 0, imed = 0;
    while ((tmax - tmin) > _deltaTemp) {
      tmed = 0.5 * (tmin + tmax);
      imed = _getCurrentNoCheck(ta, tmed);
      if (imed > ic) {
        tmax = tmed;
      } else {
        tmin = tmed;
      }
      cuenta = cuenta + 1;
      if (cuenta > iteraMAX) {
        throw RangeError("getTc(): N° iterations > $iteraMAX");
      }
    }
    return tmed;
  }

  double getTa(double tc, double ic) {
    /*
  	Returns ambient temperature [ampere]
  	tc : Conductor temperature [°C]
  	ic : Current [ampere]
  	*/
    checkConductor();
    check(tc).ge(tcMIN).le(tcMAX);

    var imin = _getCurrentNoCheck(taMAX, tc);
    var imax = _getCurrentNoCheck(taMIN, tc);
    check(ic).ge(imin).le(imax); // Ensure TA_MIN =< Ta =< TA_MAX

    var tmin = taMIN;
    var tmax = min(taMAX, tc);
    if (tmin >= tmax) {
      return tc;
    }

    var cuenta = 0;
    double tmed = 0, imed = 0;
    while ((tmax - tmin) > _deltaTemp) {
      tmed = 0.5 * (tmin + tmax);
      imed = _getCurrentNoCheck(tmed, tc);
      if (imed > ic) {
        tmin = tmed;
      } else {
        tmax = tmed;
      }
      cuenta = cuenta + 1;
      if (cuenta > iteraMAX) {
        throw RangeError("getTc(): N° iterations > $iteraMAX");
      }
    }
    return tmed;
  }
}
