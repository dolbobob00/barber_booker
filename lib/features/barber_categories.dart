import 'package:barber_booker/pages/home_page/concrete_category_page.dart';
import 'package:flutter/material.dart';

import '../domain/constants.dart';

class CategoryBuilder extends StatefulWidget {
  const CategoryBuilder({super.key, required this.selfUid});
  final String selfUid;
  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.92),
      shrinkWrap: true, // Ограничивает высоту до необходимого размера
      physics: const NeverScrollableScrollPhysics(),
      itemCount: globalServices.length,
      itemBuilder: (context, index) => Category(
        imageUrl: globalServicesImagesUrl[index],
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConcreteCategoryPage(
                selfUid: widget.selfUid,
                nameOfCategory: globalServices[index],
              ),
            ),
          );
        },
        name: globalServices[index],
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category(
      {super.key, required this.onTap, required this.name, this.imageUrl});
  final String? name;
  final VoidCallback onTap;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    return InkWell(
      splashColor: themeof.colorScheme.secondary,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: themeof.colorScheme.primary,
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.network(
                  imageUrl ??
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Noun-question-By_Adrien_Coquet%2C_FR.svg/640px-Noun-question-By_Adrien_Coquet%2C_FR.svg.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 115,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name ?? 'Null category',
                    style: themeof.textTheme.bodyMedium!.copyWith(
                        fontSize: name != null
                            ? name!.length > 20
                                ? 16.5
                                : 18.5
                            : 18.5,
                        color: themeof.colorScheme.inversePrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
