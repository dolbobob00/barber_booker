import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/user_data.dart';

class UsersControlRepository {
  final FirebaseFirestore _firestore;

  UsersControlRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<User>> getUsers() {
    return _firestore.collection('Users').snapshots().map(
      (snapshots) {
        return snapshots.docs.map(
          (doc) {
            return UserControl.fromSnapshot(doc);
          },
        ).toList();
      },
    );
  }
}
