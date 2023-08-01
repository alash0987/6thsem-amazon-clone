import 'package:amazonclone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your orders', ontap: () {}),
            AccountButton(text: 'Turn Seller', ontap: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(text: 'Log Out', ontap: () {}),
            AccountButton(text: 'Your Wishlist', ontap: () {}),
          ],
        ),
      ],
    );
  }
}
