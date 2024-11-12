import 'package:barber_booker/features/my_list_tile.dart';
import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:barber_booker/pages/barber_page/barber_profile.dart';
import 'package:barber_booker/pages/home_page/bloc/booking_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ConcreteCategoryPage extends StatelessWidget {
  const ConcreteCategoryPage(
      {super.key, required this.nameOfCategory, required this.selfUid});
  final String nameOfCategory;
  final String selfUid;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BookingBloc>(context)
      ..add(
        FetchBarbersEvent(
          categoryName: nameOfCategory,
        ),
      );
    final themeof = Theme.of(context);
    return Scaffold(
      backgroundColor: themeof.colorScheme.primary.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          nameOfCategory,
          style: themeof.textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is BookingBarbersOfSpecialCategory) {
            if (state.filteredBarbers.isEmpty) {
              return Text(
                'No available barber\'s',
                style: themeof.textTheme.titleLarge,
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NeuroWrapper(
                    shape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(
                        18,
                      ),
                    ),
                    widget: MyListTile(
                      titleText: Text(
                        state.filteredBarbers[index]['name'],
                      ),
                      phoneNumber: state.filteredBarbers[index]['phone'],
                      extra: state.filteredBarbers[index]['email'],
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BarberProfile(
                          selfUid: selfUid,
                          uid: state.filteredBarbers[index]['uid'],
                        ),
                      )),
                    ),
                  ),
                );
              },
              itemCount: state.filteredBarbers.length,
            );
          } else if (state is BookingFetchError) {
            return Center(
              child: Text(
                state.error,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: themeof.colorScheme.inversePrimary,
            ),
          );
        },
      ),
    );
  }
}
