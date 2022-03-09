import 'package:registration/core/utils/enum/address_type.dart';
import 'package:registration/models/province.dart';

class AddressInfo {
  late final String addressNo;
  late final String address;
  late final AddressType addressType;
  late final Province province;

  AddressInfo({
    required this.addressNo,
    required this.address,
    required this.addressType,
    required this.province,
  });
}
