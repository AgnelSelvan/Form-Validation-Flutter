import 'package:flutter/material.dart';
import 'package:registration/views/widgets/app_header.dart';

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
        const AppHeader(text: "Register"),
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
