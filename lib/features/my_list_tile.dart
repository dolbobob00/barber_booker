import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {super.key,
      this.subtitleText,
      this.titleText,
      this.avatar,
      this.onTap,
      this.extra,
      this.extraIcon,
      this.role,
      this.phoneNumber,
      this.rightSection});
  final Widget? titleText;
  final Widget? subtitleText;
  final String? role;
  final String? phoneNumber;
  final String? extra;
  final Widget? extraIcon;
  final Widget? avatar;
  final VoidCallback? onTap;
  final Widget? rightSection;
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    return InkWell(
      splashColor: themeof.colorScheme.secondary,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: themeof.colorScheme.onPrimary.withOpacity(
            0.1,
          ), // Основной фон виджета
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  radius: 24,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      role ?? '',
                      style: themeof.textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: themeof.colorScheme.inversePrimary),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: themeof.colorScheme.onPrimary.withOpacity(
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: titleText ?? Container(),
                      )),
                  const SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: themeof.colorScheme.onPrimary.withOpacity(
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                extra == 'null' ? 'No extra\'s' : extra ?? '',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(width: 8),
                              extraIcon ?? Container(),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            phoneNumber == 'null'
                                ? 'No number'
                                : phoneNumber ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
