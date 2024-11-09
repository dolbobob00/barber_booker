import 'package:barber_booker/repository/admin_service.dart';
import 'package:barber_booker/repository/auth_service.dart';
import 'package:barber_booker/repository/users_get.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:random_password_generator/random_password_generator.dart';
part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  UsersControlRepository usersControlRepository = UsersControlRepository();
  final AdminService _adminService = FirebaseAdminService();
  final AuthService _authService = FirebaseAuthService();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AdminBloc() : super(AdminInitial()) {
    on<AdminGetUsersEvent>(_getUsers);
    on<AdminCreateBarberEvent>(_createBarber);
    on<AdminChangeRolesEvent>(_changeRoleEvent);
    on<AdminChangeContactInfoBarberEvent>(_changeContactBarber);
    on<AdminUpdateWorkDaysEvent>(_updateWorkDays);
    on<AdminUpdateWorkTimeEvent>(_updateWorkHours);
    on<AdminUpdateGlobalServiceEvent>(_updateGlobalService);
    on<AdminDeleteGlobalService>(_deleteGlobalService);
  }

  _deleteGlobalService(
      AdminDeleteGlobalService event, Emitter<AdminState> emit) {
    _adminService.deleteGlobalService(event.uid, event.name);
  }

  _updateGlobalService(
      AdminUpdateGlobalServiceEvent event, Emitter<AdminState> emit) {
    _adminService.addGlobalService(event.uid, event.name);
  }

  _updateWorkHours(AdminUpdateWorkTimeEvent event, Emitter<AdminState> emit) {
    _adminService.changeWorkTime(
      event.uid,
      event.workStarts,
      event.workEnds,
    );
  }

  _updateWorkDays(AdminUpdateWorkDaysEvent event, Emitter<AdminState> emit) {
    _adminService.changeWorkDays(
      event.uid,
      event.workDays,
    );
  }

  _changeContactBarber(
      AdminChangeContactInfoBarberEvent event, Emitter<AdminState> emit) {
    _adminService.changeContactBarber(
      event.email,
      event.integration1,
      event.integration2,
      event.phone,
      event.uid,
    );
  }

  _changeRoleEvent(AdminChangeRolesEvent event, Emitter<AdminState> emit) {
    _adminService.changeRole(event.role, event.uid);
  }

  _createBarber(AdminCreateBarberEvent event, Emitter<AdminState> emit) async {
    final password = RandomPasswordGenerator();
    final fakePassword = password.randomPassword(
      passwordLength: 8,
      letters: true,
      numbers: true,
      uppercase: true,
      specialChar: false,
    );
    final fakeMail = "$fakePassword@${password.randomPassword(
      passwordLength: 4,
      letters: true,
      numbers: false,
      uppercase: false,
      specialChar: false,
    )}.com";
    final String uid =
        "${UniqueKey().toString().substring(2, 7) + UniqueKey().toString().substring(2, 7) + UniqueKey().toString().substring(2, 7) + UniqueKey().toString().substring(2, 7) + UniqueKey().toString().substring(2, 7)} ";
    final String specialUidCode = UniqueKey().toString().substring(2, 5);
    // = "${UniqueKey().toString().substring(2, 7)+ UniqueKey().toString().substring(2, 7)}-KZBARBER ";
    try {
      await _firebaseFirestore.collection('Barbers').doc(uid).set(
        {
          'uid': uid,
          'password': fakePassword,
          'specialUidCode': specialUidCode,
          'email': fakeMail,
          'code': 'barber',
          'name': 'Barber-${fakePassword.substring(1, 4)}',
          'phone': 'null',
          'lastdate': 'null',
        },
      );
      _firebaseFirestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('CONTACTINFO')
          .set(
        {
          'phone': '+xxxx xxx xx xx',
          'email': 'fake - $fakeMail',
          'integration1': 'instagram',
          'integration2': 'telegram',
        },
      );
       _firebaseFirestore.collection('Users').doc(uid).set(
        {
          'uid': uid,
          'password': fakePassword,
          'specialUidCode': specialUidCode,
          'email': fakeMail,
          'code': 'barber',
          'name': 'Barber-${fakePassword.substring(1, 4)}',
          'phone': 'null',
          'lastdate': 'null',
        },
      );
      _firebaseFirestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('CONTACTINFO')
          .set(
        {
          'phone': '+xxxx xxx xx xx',
          'email': 'fake - $fakeMail',
          'integration1': 'instagram',
          'integration2': 'telegram',
          'workDays': ['',''],
          'workEndTime': '18:36',
          'workInitialTime': '7:45',
        },
      );
      _firebaseFirestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('EXPERIENCE')
          .set(
        {
          'courses': 'No',
          'experience': 'Secret amount of years',
          'specialization': 'barber',
        },
      );
      _firebaseFirestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('TOPROW')
          .set(
        {
          'name': 'naming',
          'stars': '5',
        },
      );
      _firebaseFirestore
          .collection('Barbers')
          .doc(uid)
          .collection('INFORMATION')
          .doc('SERVICES')
          .set(
        {
          'GlobalServices': [],
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  _getUsers(AdminEvent event, Emitter<AdminState> emit) async {
    emit(
      AdminLoadingState(),
    );
    List<Map<String, Object>> basicUsers = [];
    List<Map<String, Object>> barberUsers = [];
    List<Map<String, Object>> adminUsers = [];
    final docs = await _adminService.fetchUserDocuments();
    final barbersDocs = await _adminService.fetchBarbersDocs();
    for (final userDoc in docs) {
      if (userDoc['code'] == 'user') {
        basicUsers.add(
          {
            'name': userDoc['name'],
            'phone': userDoc['phone'],
            'lastdate': userDoc['lastdate'],
            'uid': userDoc['uid'],
            'code': userDoc['code'],
          },
        );
      } else if (userDoc['code'] == 'admin') {
        adminUsers.add(
          {
            'name': userDoc['name'],
            'phone': userDoc['phone'],
            'lastdate': userDoc['lastdate'],
            'uid': userDoc['uid'],
            'code': userDoc['code'],
            'specialUidCode': userDoc['specialUidCode']
          },
        );
      }
    }
    for (final barberDoc in barbersDocs) {
      barberUsers.add(
        {
          'name': barberDoc['name'],
          'phone': barberDoc['phone'],
          'lastdate': barberDoc['lastdate'],
          'uid': barberDoc['uid'],
          'code': barberDoc['code'],
          'specialUidCode': barberDoc['specialUidCode'],
        },
      );
    }
    emit(
      AdminDataState(
        adminUsers: adminUsers,
        barberUsers: barberUsers,
        basicUsers: basicUsers,
      ),
    );
  }
}
