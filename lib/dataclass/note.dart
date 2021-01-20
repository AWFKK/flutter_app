class Note {
  int _id;
  String _userId;
  String _storeId;
  String _totalQuantity;
  String _unitPrice;
  String _price;
  String _discount;
  String _unit;


  Note(this._userId, this._storeId, this._totalQuantity,
      this._unitPrice, this._price, this._discount, this._unit);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._userId = obj['userid'];
    this._storeId = obj['storeid'];
    this._totalQuantity = obj['totalQuantity'];
    this._unitPrice = obj['unitPrice'];
    this._price = obj['price'];
    this._discount = obj['dicount'];
    this._unit = obj['unit'];
  }

  int get id => _id;
  String get userid => _userId;
  String get storid => _storeId;
  String get totalQuantity => _totalQuantity;
  String get unitPrice => _unitPrice;
  String get prices => _price;
  String get dicount => _discount;
  String get unit => _unit;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['userid'] = _userId;
    map['storeid'] = _storeId;
    map['totalQuantity'] = _totalQuantity;
    map['unitPrice'] = _unitPrice;
    map['price'] = _price;
    map['dicount'] = _discount;
    map['unit'] = _unit;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._userId = map['userid'];
    this._storeId = map['storeid'];
    this._totalQuantity = map['totalQuantity'];
    this._unitPrice = map['unitPrice'];
    this._price = map['price'];
    this._discount = map['dicount'];
    this._unit = map['unit'];

  }

}
