import 'package:registration/core/utils/enum/education.dart';

class PersonalInfo {
  late int aadharNumber;
  late String fullName;
  late int bankAccount;
  late Education education;
  late String dob;

  PersonalInfo({
    required this.aadharNumber,
    required this.bankAccount,
    required this.dob,
    required this.education,
    required this.fullName,
  });
}
