class Entry {
  int _id;
  String _entry;
  String _supportinfo;
  String _pronunc;
  String _partofsp;
  String _def;

  Entry(this._id, this._entry,  this._supportinfo, this._pronunc, this._partofsp, this._def);

  Entry.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._entry = obj['entry'];
    this._supportinfo = obj['supportinfo'];
    this._pronunc = obj['pronunc'];
    this._partofsp = obj['partofsp'];
    this._def = obj['def'];
  }

  int get id => _id;
  String get entry => _entry;
  String get supportinfo => _supportinfo;
  String get pronunc => _pronunc;
  String get partofsp => _partofsp;
  String get def => _def;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["entry"] = _entry;
    map["supportinfo"] = _supportinfo;
    map["pronunc"] = _pronunc;
    map["partofsp"] = _partofsp;
    map["def"] = _def;
    return map;
  }
}