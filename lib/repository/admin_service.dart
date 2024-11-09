import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AdminService {
  void changeRole(String role, String uid);
  Future<List<QueryDocumentSnapshot>> fetchUserDocuments();
  Future<List<QueryDocumentSnapshot>> fetchBarbersDocs();
  void changeContactBarber(
    String email,
    String integration1,
    String integration2,
    String phone,
    String uid,
  );
  void changeWorkTime(String uid, String initialTime, String endTime);
  void changeWorkDays(String uid, List<dynamic> workDays);
  void addGlobalService(String uid, String name);
  void deleteGlobalService(String uid, String name);
}

class FirebaseAdminService implements AdminService {
  final FirebaseFirestore _firestore;

  FirebaseAdminService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUsers() {
    return _firestore.collection('Users').snapshots();
  }

  @override

  /// Функция для получения списка пользователей из Firestore
  Future<List<QueryDocumentSnapshot>> fetchUserDocuments() async {
    final querySnapshot = await _firestore.collection('Users').get();
    return querySnapshot.docs;
  }

  Stream<QuerySnapshot> getBarbers() {
    return _firestore.collection('Barbers').snapshots();
  }

  @override

  /// Функция для получения списка пользователей из Firestore
  Future<List<QueryDocumentSnapshot>> fetchBarbersDocs() async {
    final querySnapshot = await _firestore.collection('Barbers').get();
    return querySnapshot.docs;
  }

  @override
  void deleteGlobalService(String uid, String name) async {
    final docRef = FirebaseFirestore.instance
        .collection('Barbers')
        .doc(uid)
        .collection('INFORMATION')
        .doc('SERVICES');

    docRef.update({
      'GlobalServices': FieldValue.arrayRemove([name])
    });
  }

  @override
  void addGlobalService(String uid, String name) {
    _firestore
        .collection('Barbers')
        .doc(uid)
        .collection('INFORMATION')
        .doc('SERVICES')
        .update(
      {
        'GlobalServices': FieldValue.arrayUnion(
          [name],
        ),
      },
    );
  }

  @override
  void changeWorkTime(String uid, String initialTime, String endTime) async {
    _firestore
        .collection('Barbers')
        .doc(uid)
        .collection('INFORMATION')
        .doc('CONTACTINFO')
        .update(
      {
        'workInitialTime': initialTime,
        'workEndTime': endTime,
      },
    );
  }

  @override
  void changeWorkDays(String uid, List<dynamic> workDays) async {
    _firestore
        .collection('Barbers')
        .doc(uid)
        .collection('INFORMATION')
        .doc('CONTACTINFO')
        .update(
      {
        'workDays': workDays as List<String>,
      },
    );
  }

  @override
  void changeContactBarber(
    String email,
    String integration1,
    String integration2,
    String phone,
    String uid,
  ) {
    _firestore
        .collection('Barbers')
        .doc(uid)
        .collection('INFORMATION')
        .doc('CONTACTINFO')
        .update(
      {
        'phone': phone,
        'email': email,
        'integration1': integration1,
        'integration2': integration2,
      },
    );
    _firestore.collection('Barbers').doc(uid).update(
      {
        'phone': phone,
        'email': email,
      },
    );
  }

  @override
  void changeRole(String role, String uid) async {
    await _firestore.collection('Users').doc(uid).update(
      {'code': role},
    );
  }
}
