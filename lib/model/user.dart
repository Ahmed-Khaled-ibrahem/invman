class UserData {

  String uid;
  String firstName;
  String lastName;
  String email;
  String password;
  String role;
  late DateTime createdAt;
  bool blocked;


  UserData({
        required this.uid,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.password,
        required this.role,
        this.blocked = false,
      }){
    createdAt = DateTime.now();
  }

  void printData(){
    toMap().forEach((key, value) {
     print('key: $key , value : $value');
    });
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['uid'] = uid;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['role'] = role;
    map['createdAt'] = createdAt;
    map['blocked'] = blocked;
    return map;
  }

  UserData.fromMapObject(Map<String, dynamic> map) :
        uid = map['uid'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        email = map['email'],
        password = map['password'],
        createdAt = map['createdAt'],
        role = map['role'],
        blocked = map['blocked'];
}