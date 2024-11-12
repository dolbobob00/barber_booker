import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  BookingBloc() : super(BookingInitial()) {
    on<FetchBarbersEvent>(_fetchBarberOfSpecialCategory);
  }

  _fetchBarberOfSpecialCategory(
      FetchBarbersEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoadingState());

    // Создайте пустой список для хранения отфильтрованных барберов
    List<Map<String, dynamic>> filteredBarbers = [];

    try {
      // Получите все документы в коллекции 'Barbers'
      final barbersCollection =
          await _firebaseFirestore.collection('Barbers').get();

      for (var barberDoc in barbersCollection.docs) {
        // Проверка на поле 'code'
        if (barberDoc['code'] == 'barber') {
          // Получите подколлекцию 'INFORMATION' > 'SERVICES' документа барбера
          final servicesCollection = await _firebaseFirestore
              .collection('Barbers')
              .doc(barberDoc.id)
              .collection('INFORMATION')
              .doc('SERVICES')
              .get();

          // Проверка наличия документа 'SERVICES'
          if (servicesCollection.exists) {
            // Получите массив 'GlobalServices' из документа
            List<dynamic> globalServices = servicesCollection['GlobalServices'];

            // Проверьте, содержит ли массив 'GlobalServices' переданную строку
            if (globalServices.contains(event.categoryName)) {
              // Если строка найдена, добавьте данные барбера в массив
              filteredBarbers.add({
                'uid': barberDoc.id,
                'email': barberDoc['email'],
                'name': barberDoc['name'],
                'phone': barberDoc['phone'],
              });
            }
          }
        }
      }

      // Отправьте отфильтрованный список барберов через состояние
      emit(
        BookingBarbersOfSpecialCategory(
          filteredBarbers: filteredBarbers,
        ),
      );
    } catch (e) {
      print("Ошибка при получении барберов: $e");
      emit(
        BookingFetchError(
          error: e.toString(),
        ),
      );
    }
  }
}
