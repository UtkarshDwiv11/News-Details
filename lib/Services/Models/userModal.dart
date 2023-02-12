class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? password;
  String? provider="Email";

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.password,this.provider});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      password: map['password'],
      provider: map['provider']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'password': password,
      'provider':provider

    };
  }
}