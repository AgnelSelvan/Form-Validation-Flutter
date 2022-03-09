import 'package:flutter/material.dart';

class BlocErrorContainer extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
  const BlocErrorContainer({
    Key? key,
    required this.errorMessage,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.refresh,
                color: Colors.blue[400]!,
              ))
        ],
      ),
    );
  }
}
