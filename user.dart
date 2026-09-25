class User {
  late int _userId;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _mobile;
  late String _dob;
  late String _city;
  late String _gender;
  late String _hobbies;
  late String _password;
  bool _isFavourite = false;

  // Getter & Setter
  int get UserID => _userId;
  set UserID(int value) {
    _userId = value;
  }

  String get FirstName => _firstName;
  set FirstName(String value) {
    _firstName = value;
  }

  String get LastName => _lastName;
  set LastName(String value) {
    _lastName = value;
  }

  String get Email => _email;
  set Email(String value) {
    _email = value;
  }

  String get Mobile => _mobile;
  set Mobile(String value) {
    _mobile = value;
  }

  String get DOB => _dob;
  set DOB(String value) {
    _dob = value;
  }

  String get City => _city;
  set City(String value) {
    _city = value;
  }

  String get Gender => _gender;
  set Gender(String value) {
    _gender = value;
  }

  String get Hobbies => _hobbies;
  set Hobbies(String value) {
    _hobbies = value;
  }

  String get Password => _password;
  set Password(String value) {
    _password = value;
  }

  bool get isFavourite => _isFavourite;
  set isFavourite(bool value) {
    _isFavourite = value;
  }

  // Conver object into Map for SQLite operations
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapData = {
      'FirstName': _firstName,
      'LastName': _lastName,
      'Email': _email,
      'Mobile': _mobile,
      'DOB': _dob,
      'City': _city,
      'Gender': _gender,
      'Hobbies': _hobbies,
      'Password': _password,
      'isFavourite': _isFavourite,
    };
    return mapData;
  }

  @override
  String toString() {
    return 'User(UserID: $_userId, Name: $_firstName $_lastName, Email: $_email, Mobile: $_mobile, City: $_city, Gender: $_gender, Fav: $_isFavourite)';
  }
}
