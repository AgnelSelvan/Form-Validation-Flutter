import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:registration/core/error/failures.dart';
import 'package:registration/core/utils/enum/address_type.dart';
import 'package:registration/core/utils/enum/education.dart';
import 'package:registration/models/address_info.dart';
import 'package:registration/models/personal_info.dart';
import 'package:registration/models/province.dart';

class RegisterNotifier extends ChangeNotifier {
  Education? _education;
  Education? get education => _education;
  set education(Education? education) {
    _education = education;
    notifyListeners();
  }

  PersonalInfo? _personalInfo;
  PersonalInfo? get personalInfo => _personalInfo;
  set personalInfo(PersonalInfo? personalInfo) {
    _personalInfo = personalInfo;
    notifyListeners();
  }

  bool canNavigate() {
    return false;
  }

  //! Address Details Datas
  AddressType? _addressType;
  AddressType? get addressType => _addressType;
  set addressType(AddressType? addressType) {
    _addressType = addressType;
    notifyListeners();
  }

  Province? _province;
  Province? get province => _province;
  set province(Province? province) {
    _province = province;
    notifyListeners();
  }

  AddressInfo? _addressInfo;
  AddressInfo? get addressInfo => _addressInfo;
  set addressInfo(AddressInfo? addressInfo) {
    _addressInfo = addressInfo;
  }

  Either<Failure, bool> onSubmitTap(String addressNo, String address) {
    if (addressType == null) {
      return Left(UnknownFailure("Please Select A Address Type"));
    } else if (province == null) {
      return Left(UnknownFailure("Please Select A Province"));
    }
    _addressInfo = AddressInfo(
      addressNo: addressNo,
      address: address,
      addressType: _addressType!,
      province: _province!,
    );
    return const Right(true);
  }
}
