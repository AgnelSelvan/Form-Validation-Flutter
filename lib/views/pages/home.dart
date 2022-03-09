import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/view_model/provider/register.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RegisterNotifier registerNotifier;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      registerNotifier = Provider.of<RegisterNotifier>(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
