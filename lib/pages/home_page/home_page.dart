import 'package:barber_booker/features/banner_carousel.dart';
import 'package:barber_booker/features/barber_categories.dart';
import 'package:barber_booker/features/my_list_tile.dart';
import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/pages/auth_reg_pages/auth_bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barber Shop"),
      ),
      backgroundColor: themeof.colorScheme.primary.withOpacity(0.85),
      drawer: Drawer(
        // width: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: themeof.colorScheme.primary,
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.person,
                color: themeof.colorScheme.secondary,
                size: 64,
              ),
            ),
            NeuroWrapper(
              shape: NeumorphicBoxShape.roundRect(
                const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              widget: MyListTile(
                titleText: BlocBuilder<AuthBloc, AuthState>(
                  bloc: authBloc,
                  builder: (context, state) {
                    if (state is AuthLoginState) {
                      return Text(
                        'Hello, ${state.user!.displayName ?? state.user!.email!}',
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Exit account',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                context.go('/afterSplash');
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: NeuroWrapper(
                widget: Padding(
                  padding: const EdgeInsets.all(
                    25,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/img/logo.png',
                        color: themeof.colorScheme.inversePrimary,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        'There can be your ads or logo',
                        style: themeof.textTheme.bodySmall!.copyWith(
                            color: themeof.colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                ),
                shape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(
                    25,
                  ),
                ),
              ),
            ),
            const CarouselWithIndicatorDemo(),
            BlocBuilder<AuthBloc, AuthState>(
              bloc: authBloc,
              builder: (context, state) {
                if (state is AuthLoginState) {
                  return CategoryBuilder(
                    selfUid: state.user!.uid,
                  );
                }
                return const CircularProgressIndicator.adaptive();
              },
            ),
            Container(
              width: double.infinity,
              height: 155,
              decoration: BoxDecoration(
                color: themeof.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instagram: @barbershop_arys',
                      style: themeof.textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: themeof.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'Street location: Егемен Казахстан, 46',
                      style: themeof.textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: themeof.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'Basic work time: 10:00-20:00',
                      style: themeof.textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: themeof.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'Contact phone: 8 (776) 388-89-88',
                      style: themeof.textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: themeof.colorScheme.secondary,
                      ),
                    ),
                    Center(
                      child: Text(
                        'THE TERRITORY OF REAL MEN',
                        style: themeof.textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      'all rights is in hands of boris',
                      style: themeof.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authBloc.add(
            SignOutEvent(),
          );
        },
      ),
    );
  }
}

// class BarberPage extends StatefulWidget {
//   const BarberPage(
//       {super.key, required this.dayEndHour, required this.dayStartHour});
//   final int dayStartHour;
//   final int dayEndHour;
//   @override
//   State<BarberPage> createState() => _BarberPageState();
// }

// class _BarberPageState extends State<BarberPage> {
//   final now = DateTime.now();
//   late BookingService mockBookingService;

//   @override
//   void initState() {
//     super.initState();
//     // DateTime.now().startOfDay
//     // DateTime.now().endOfDay
//     mockBookingService = BookingService(
//         serviceName: 'Mock Service',
//         serviceDuration: 30,
//         bookingEnd:
//             DateTime(now.year, now.month, now.day, widget.dayEndHour, 0),
//         bookingStart:
//             DateTime(now.year, now.month, now.day, widget.dayStartHour, 0));
//   }

//   Stream<dynamic>? getBookingStreamMock(
//       {required DateTime end, required DateTime start}) {
//     return Stream.value([]);
//   }

//   Future<dynamic> uploadBookingMock(
//       {required BookingService newBooking}) async {
//     await Future.delayed(const Duration(seconds: 1));
//     converted.add(DateTimeRange(
//         start: newBooking.bookingStart, end: newBooking.bookingEnd));
//     print('${newBooking.toJson()} has been uploaded');
//   }

//   List<DateTimeRange> converted = [];

//   List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
//     ///here you can parse the streamresult and convert to [List<DateTimeRange>]
//     ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
//     ///disabledDays will properly work with real data
//     DateTime first = now;
//     DateTime tomorrow = now.add(const Duration(days: 1));
//     DateTime second = now.add(const Duration(minutes: 55));
//     DateTime third = now.subtract(const Duration(minutes: 240));
//     DateTime fourth = now.subtract(const Duration(minutes: 500));
//     converted.add(
//         DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
//     converted.add(DateTimeRange(
//         start: second, end: second.add(const Duration(minutes: 23))));
//     converted.add(DateTimeRange(
//         start: third, end: third.add(const Duration(minutes: 15))));
//     converted.add(DateTimeRange(
//         start: fourth, end: fourth.add(const Duration(minutes: 50))));

//     //book whole day example
//     converted.add(DateTimeRange(
//         start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
//         end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
//     return converted;
//   }

//   List<DateTimeRange> generatePauseSlots() {
//     return [
//       DateTimeRange(
//           start: DateTime(now.year, now.month, now.day, 12, 0),
//           end: DateTime(now.year, now.month, now.day, 13, 0))
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeof = Theme.of(context);
//     final authBloc = BlocProvider.of<AuthBloc>(context);
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         authBloc.add(
//           SignOutEvent(),
//         );
//       }),
//       body: Center(
//         child: BookingCalendar(
//           bookingService: mockBookingService,
//           convertStreamResultToDateTimeRanges: convertStreamResultMock,
//           getBookingStream: getBookingStreamMock,
//           uploadBooking: uploadBookingMock,
//           pauseSlots: generatePauseSlots(),
//           pauseSlotText: 'LUNCH',
//           hideBreakTime: false,
//           loadingWidget: const Text('Fetching data...'),
//           uploadingWidget: const CircularProgressIndicator(),
//           startingDayOfWeek: StartingDayOfWeek.tuesday,
//           wholeDayIsBookedWidget:
//               const Text('Sorry, for this day everything is booked'),
//           //disabledDates: [DateTime(2023, 1, 20)],
//           //disabledDays: [6, 7],
//           //CUSTOMIZATION
//           availableSlotTextStyle: TextStyle(color: Colors.black),
//           bookedSlotTextStyle: TextStyle(color: Colors.black),
//           availableSlotColor: Colors.green,
//           bookedSlotColor: Colors.red,
//           pauseSlotColor: Colors.orange,
//           selectedSlotTextStyle: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
