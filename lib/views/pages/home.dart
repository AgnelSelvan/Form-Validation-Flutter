import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration/core/utils/string.dart';
import 'package:registration/models/address_info.dart';
import 'package:registration/models/personal_info.dart';
import 'package:registration/view_model/provider/register.dart';
import 'package:registration/views/pages/register.dart';
import 'package:registration/views/widgets/app_header.dart';
import 'package:registration/views/widgets/card.dart';

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
      body: buildBody(context),
    );
  }

  SafeArea buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(context),
            const SizedBox(
              height: 20,
            ),
            userTabbar(context),
            Consumer<RegisterNotifier>(builder: (_, state, child) {
              return SizedBox(
                width: double.infinity,
                height: 500,
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  children: [
                    state.personalInfo == null
                        ? const Text("Datas are missing")
                        : personalInfoTab(state.personalInfo!),
                    state.addressInfo == null
                        ? const Text("Datas are missing")
                        : addressInfoTab(state.addressInfo!),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  TabBar userTabbar(BuildContext context) {
    return TabBar(
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
    );
  }

  Row header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppHeader(text: "Home"),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.red[500],
          ),
          onPressed: () {
            Provider.of<RegisterNotifier>(context, listen: false)
                .resetAllData();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
          },
        )
      ],
    );
  }

  Widget addressInfoTab(AddressInfo addressInfo) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Table(
          children: [
            TableRow(children: [
              Text("Address Type",
                  style: TextStyle(
                      color: Colors.grey[500], fontWeight: FontWeight.normal)),
              Text(
                addressInfo.addressType.name.capitalize(),
              ),
            ]),
            TableRow(children: [
              Text("Address No",
                  style: TextStyle(
                      color: Colors.grey[500], fontWeight: FontWeight.normal)),
              Text(
                addressInfo.addressNo.capitalize(),
              ),
            ]),
            TableRow(children: [
              Text("Address",
                  style: TextStyle(
                      color: Colors.grey[500], fontWeight: FontWeight.normal)),
              Text(
                addressInfo.address.capitalize(),
              ),
            ]),
            TableRow(children: [
              Text("Province",
                  style: TextStyle(
                      color: Colors.grey[500], fontWeight: FontWeight.normal)),
              Text(
                (addressInfo.province.nama ?? "").capitalize(),
              ),
            ]),
          ],
        )
      ],
    );
  }

  Column personalInfoTab(PersonalInfo personalInfo) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Icon(
          Icons.account_circle,
          size: 120,
          color: Colors.grey[500],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              personalInfo.fullName,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "( ${personalInfo.dob} )",
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              DataCard(
                icon: Icons.account_balance,
                title: "Account Number",
                value: personalInfo.bankAccount.toString(),
                color: Colors.red[400]!,
              ),
              const SizedBox(
                width: 5,
              ),
              DataCard(
                icon: Icons.account_balance_wallet_rounded,
                title: "Aadhar Number",
                value: personalInfo.aadharNumber.toString(),
                color: Colors.green[400]!,
              ),
              const SizedBox(
                width: 5,
              ),
              DataCard(
                icon: Icons.school,
                title: "Education",
                value: personalInfo.education.name.toString(),
                color: Colors.orange[400]!,
              ),
            ],
          ),
        )
      ],
    );
  }
}
