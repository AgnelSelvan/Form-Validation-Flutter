import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/view_model/provider/register.dart';
import 'package:registration/views/widgets/app_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(text: "Home"),
              const SizedBox(
                height: 20,
              ),
              TabBar(
                physics: const BouncingScrollPhysics(),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: Colors.grey[200],
                ),
                tabs: [
                  Tab(
                    child: Text(
                      "Personal Info",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Address Details",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
                controller: _controller,
              ),
              Consumer<RegisterNotifier>(builder: (_, state, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    children: [
                      Center(
                          child: Text(
                        (state.personalInfo?.aadharNumber).toString(),
                        style: const TextStyle(fontSize: 40),
                      )),
                      Center(
                          child: Text(
                        (state.addressInfo?.address).toString(),
                        style: const TextStyle(fontSize: 40),
                      )),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
