import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:registration/app.dart';
import 'package:registration/core/network/network_info.dart';
import 'package:registration/data/data_source/province.dart';
import 'package:registration/view_model/bloc/province_bloc.dart';
import 'package:registration/view_model/provider/register.dart';

import 'injection.dart' as di;
import 'repository/province.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<ProvinceBloc>(
          create: (context) => ProvinceBloc(
              provinceRepositoryImpl: ProvinceRepositoryImpl(
            dataSourceImpl: ProvinceRemoteDataSourceImpl(),
            info: NetworkInfoImpl(InternetConnectionChecker()),
          )),
        ),
      ],
      child: ChangeNotifierProvider(
          create: (_) => RegisterNotifier(), child: const MyApp())));
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             // FutureBuilder(
//             //     future: ProvinceRepositoryImpl().getProvince(),
//             //     builder: (context, snapshot) {
//             //       return Center(child: Text(snapshot.data.toString()));
//             //     }),
//             BlocBuilder<ProvinceBloc, ProvinceState>(
//                 builder: (context, state) {
//               if (state is Empty) {
//                 return const Text("Empty...");
//               } else if (state is Loading) {
//                 return const CircularProgressIndicator();
//               } else if (state is Loaded) {
//                 return Text("${state.provinceResponse.provinsi?.length}");
//               } else if (state is Error) {
//                 return Text(state.message);
//               } else {
//                 const Text("Hello");
//               }
//               return const Text("data");
//             }),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             TextButton(
//               onPressed: () {
//                 BlocProvider.of<ProvinceBloc>(context)
//                     .add(const GetProvince());
//               },
//               child: const Text("Search"),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
