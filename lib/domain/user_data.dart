import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? name;
  String? role;
  String? uid;
  User({this.name, this.role, this.uid});
}

class UserControl {
  static User fromSnapshot(DocumentSnapshot doc) {
    String name = doc['name'];
    User user = User(
      name: name.isEmpty ? doc['email'] : name,
      role: doc['role'],
      uid: doc['uid'],
    );
    return user;
  }
}
