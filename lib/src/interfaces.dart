// CRISTIAN ECHEVERRÍA RABÍ

//------------------------------------------------------------------------------

abstract class PrettyPrint {
  String getTitle();

  List getData();

  List getFormatedData([int tab = 4]) {
    var n = " " * tab;
    var fl = getData().map((x) => n + x);
    return [getTitle(), ...fl];
  }

  String formatData([int level = 0, int tab = 4]) {
    return getFormatedData(tab).join("\n");
  }

  @override
  String toString() {
    return formatData();
  }
}
