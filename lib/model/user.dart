class UserData {

  String uid;
  String email;
  bool verified;
  String targetEmail;
  Map roles;
  // bool checkStock;

  UserData({
        required this.uid,
        required this.email,
        required this.targetEmail,
        required this.verified,
        required this.roles
      });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['targetEmail'] = targetEmail;
    map['email'] = email;
    map['uid'] = uid;
    map['verified'] = verified;
    map['roles'] = roles;
    // map['checkStock'] = checkStock;
    return map;
  }

  UserData.fromMapObject(Map<String, dynamic> map) :
    uid = map['uid'],
    verified = map['verified'],
    email = map['email'],
    targetEmail = map['targetEmail'],
    roles = map['roles'];
    // checkStock = map['checkStock'];

}