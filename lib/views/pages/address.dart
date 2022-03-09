import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:registration/core/network/network_info.dart';
import 'package:registration/core/utils/enum/address_type.dart';
import 'package:registration/core/utils/enum/input.dart';
import 'package:registration/core/utils/input_validator.dart';
import 'package:registration/core/utils/string.dart';
import 'package:registration/core/utils/utils.dart';
import 'package:registration/models/province.dart';
import 'package:registration/res/colors.dart';
import 'package:registration/view_model/bloc/provinceState.dart';
import 'package:registration/view_model/bloc/province_bloc.dart';
import 'package:registration/view_model/bloc/province_event.dart';
import 'package:registration/view_model/provider/register.dart';
import 'package:registration/views/pages/home.dart';
import 'package:registration/views/pages/register.dart';
import 'package:registration/views/widgets/dropdown.dart';
import 'package:registration/views/widgets/error_container.dart';
import 'package:registration/views/widgets/loader.dart';
import 'package:registration/views/widgets/register_header.dart';
import 'package:registration/views/widgets/textfield.dart';

class AddressInfoScreen extends StatefulWidget {
  const AddressInfoScreen({Key? key}) : super(key: key);

  @override
  State<AddressInfoScreen> createState() => _AddressInfoScreenState();
}

class _AddressInfoScreenState extends State<AddressInfoScreen>
    with InputValidator {
  final formGlobalKey = GlobalKey<FormState>();
  final addressNumberController = TextEditingController();
  final addressController = TextEditingController();
  late RegisterNotifier registerProvider;
  late NetworkInfoImpl networkInfo;

  void performInit() {
    registerProvider = Provider.of<RegisterNotifier>(context, listen: false);

    BlocProvider.of<ProvinceBloc>(context).add(const GetProvince());
    networkInfo = NetworkInfoImpl(InternetConnectionChecker());
    networkInfo.onNetworkStatusChange.listen((event) {
      debugPrint("Event: $event");
      if (event == InternetConnectionStatus.connected) {
        Utiliy.showSuccessSnackbar(context, message: "Connection established");
        registerProvider.province = null;
        BlocProvider.of<ProvinceBloc>(context).add(const GetProvince());
      } else {
        Utiliy.showErrorSnackbar(context, message: "No Internet Connection");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    performInit();

    super.initState();
  }

  void onSubmitTap() {
    if (formGlobalKey.currentState?.validate() ?? false) {
      formGlobalKey.currentState?.save();
      final failOrSucc = registerProvider.onSubmitTap(
          addressNumberController.text, addressController.text);
      failOrSucc.fold(
          (l) => Utiliy.showErrorSnackbar(context, message: l.toString()), (r) {
        if (r) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      });
    } else {
      Utiliy.showErrorSnackbar(context, message: "Please enter all Details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        registerProvider.province = null;
        return true;
      },
      child: buildBody(context),
    );
  }

  Scaffold buildBody(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: addressForm(),
            ),
          ),
        ),
      ),
    );
  }

  Form addressForm() {
    return Form(
      key: formGlobalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RegisterHeader(
            header: "Address Details",
          ),
          addressDropdown(),
          buildTextFields(),
          getProvinceBloc(),
          const SizedBox(
            height: 30,
          ),
          RegisterButton(
            text: "Submit",
            btnColor: AppColors.lightPrimaryColor,
            childColor: Colors.white,
            onPressed: onSubmitTap,
          )
        ],
      ),
    );
  }

  BlocBuilder<ProvinceBloc, ProvinceState> getProvinceBloc() {
    return BlocBuilder<ProvinceBloc, ProvinceState>(builder: (context, state) {
      if (state is Empty) {
        return const Text("Empty...");
      } else if (state is Loading) {
        return const CustomLoader();
      } else if (state is Loaded) {
        return Consumer<RegisterNotifier>(builder: (_, a, child) {
          return RegisterDropdown<Province?>(
              hintText: "Select Your Province",
              value: a.province,
              items: (state.provinceResponse.provinsi ?? [])
                  .map((e) => DropdownMenuItem<Province>(
                      value: e, child: Text(e.nama.toString().capitalize())))
                  .toList(),
              onChanged: (val) => a.province = val);
        });
      } else if (state is Error) {
        return BlocErrorContainer(
          onPressed: () =>
              BlocProvider.of<ProvinceBloc>(context).add(const GetProvince()),
          errorMessage: state.message,
        );
      }
      return const CircularProgressIndicator();
    });
  }

  Column buildTextFields() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        RegisterTextField(
          labelText: "Home / Office No",
          hintText: "",
          controller: addressNumberController,
          leadingIcon: Icons.dialpad,
          inputType: InputType.addressNo,
          validator: validateAddressNo,
          textInputType: TextInputType.streetAddress,
        ),
        const SizedBox(
          height: 20,
        ),
        RegisterTextField(
          labelText: "Home / Office Address",
          hintText: "",
          controller: addressController,
          leadingIcon: Icons.apartment_rounded,
          inputType: InputType.address,
          validator: validateAddress,
          maxLines: 4,
          textInputType: TextInputType.streetAddress,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Consumer<RegisterNotifier> addressDropdown() {
    return Consumer<RegisterNotifier>(builder: (_, a, child) {
      return RegisterDropdown<AddressType?>(
          hintText: "Select Address Type",
          prefixIcon: a.addressType == null
              ? Icons.apps_sharp
              : a.addressType == AddressType.home
                  ? Icons.house
                  : Icons.apartment_sharp,
          value: a.addressType,
          items: AddressType.values
              .map((e) => DropdownMenuItem<AddressType>(
                  value: e, child: Text(e.name.capitalize())))
              .toList(),
          onChanged: (val) => a.addressType = val);
    });
  }
}
