// CRISTIAN ECHEVERRÍA RABÍ

//------------------------------------------------------------------------------

/*
Define constants for cer_conductor

Formula to use in CurrentCalc for current calculations
formulaCLASSIC = "CLASSIC"	Identifies CLASSIC formula
formulaIEEE    = "IEEE"	  Identifies IEEE formula

Ambient temperature in °C
taMIN = -90  Minimum value for ambient temperature
             World lowest -82.2°C Vostok Antartica 21/07/1983
taMAX =  90  Maximum value for ambient temperature
             World highest 58.2°C Libia 13/09/1922

Conductor temperature [°C]
tcMIN =  -90  Minimum value for conductor temperature
tcMAX = 2000  Maximum value for conductor temperature
              Copper melt at 1083 °C

Iterations
iteraMAX = 20000  Maximum number of iterations

Conductor tension [kg]
tensionMAX = 50000  Maximum conductor tension
*/

// Current calculus formulas
const formulaCLASSIC = "CLASSIC";
const formulaIEEE = "IEEE";

// Ambient temperature
const double taMIN = -90.0;
const double taMAX = 90.0;

// Conductor temperature
const double tcMIN = -90.0;
const double tcMAX = 2000.0;

// Iterations
const iteraMAX = 20000;

// Conductor tension
const tensionMAX = 50000;
