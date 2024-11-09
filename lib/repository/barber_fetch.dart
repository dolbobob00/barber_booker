import 'package:cloud_firestore/cloud_firestore.dart';

class BarberFetch {
  final FirebaseFirestore _firestore;

  BarberFetch({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  Future<Map<String, dynamic>?> fetchExperienceInfo(String uid) async {
    try {
      final allMap = await _firestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('EXPERIENCE')
          .get();
      final returnedMap = {
        'experience': allMap['experience'],
        'courses': allMap['courses'],
        'specialization': allMap['specialization']
      };
      return returnedMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchGlobalServices(String uid) async {
    try {
      final allMap = await _firestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('SERVICES')
          .get();
      final returnedMap = {
        'GlobalServices': allMap['GlobalServices'],
      };
      return returnedMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchTopRowInfo(String uid) async {
    try {
      final allMap = await _firestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('TOPROW')
          .get();
      final returnedMap = {
        'name': allMap['name'],
        'stars': allMap['stars'],
      };
      return returnedMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchBarberContactInfo(String uid) async {
    try {
      final allMap = await _firestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('CONTACTINFO')
          .get();
      try {
        final returnedMap = {
          'phone': allMap['phone'],
          'email': allMap['email'],
          'integration1': allMap['integration1'],
          'integration2': allMap['integration2'],
          'workDays': allMap['workDays'],
          'initialTime': allMap['workInitialTime'],
          'endTime': allMap['workEndTime'],
        };
        return returnedMap;
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
