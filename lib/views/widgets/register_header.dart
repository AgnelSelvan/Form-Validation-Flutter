import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    Key? key,
    required this.header,
  }) : super(key: key);
  final String header;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          "Register",
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          header,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
