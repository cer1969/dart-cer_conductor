// CRISTIAN ECHEVERRÍA RABÍ

//------------------------------------------------------------------------------
// Comparison functions

bool _lt(num a, num b) => a < b;
bool _le(num a, num b) => a <= b;
bool _ge(num a, num b) => a >= b;
bool _gt(num a, num b) => a > b;
bool _numIn(num a, List blist) => blist.contains(a);
bool _strIn(String a, List blist) => blist.contains(a);

//------------------------------------------------------------------------------

class ValueException implements Exception {
  String _msg = "Invalid value";

  ValueException([String msg = 'Invalid value']) {
    _msg = msg;
  }

  @override
  String toString() {
    return "ValueException: $_msg";
  }
}

//------------------------------------------------------------------------------

class _CheckNum {
  /*
	Class for number testing with error raising
	*/
  final num value;

  _CheckNum(this.value);

  _CheckNum _compare(Function compFunc, String txt, num limit) {
    if (!compFunc(value, limit)) {
      throw ValueException("Required value $txt $limit ($value entered)");
    }
    return this;
  }

  _CheckNum lt(num limit) => _compare(_lt, "<", limit);
  _CheckNum le(num limit) => _compare(_le, "<=", limit);
  _CheckNum gt(num limit) => _compare(_gt, ">", limit);
  _CheckNum ge(num limit) => _compare(_ge, ">", limit);
  _CheckNum isIn(List blist) {
    if (!_numIn(value, blist)) {
      throw ValueException("Required value in $blist ($value entered)");
    }
    return this;
  }
}

//------------------------------------------------------------------------------

class _CheckStr {
  /*
	Class for string testing with error raising
	*/
  final String value;

  _CheckStr(this.value);

  _CheckStr isIn(List blist) {
    if (!_strIn(value, blist)) {
      throw ValueException("Required value in $blist ($value entered)");
    }
    return this;
  }
}

//------------------------------------------------------------------------------
// Public function check

_CheckNum check(num value) => _CheckNum(value);
_CheckStr checkStr(String value) => _CheckStr(value);
