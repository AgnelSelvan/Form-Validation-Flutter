mixin InputValidator {
  String? validateAadharID(String? value) {
    if (value == null || value == "") {
      return "Please Enter Aadhar ID Number";
    } else {
      final val = int.tryParse(value);
      if (value.trim().length != 12 || val == null) {
        return "Please Enter Valid Aadhar ID";
      }
    }

    return null;
  }

  String? validateFullName(String? value) {
    bool found = (value?.contains(RegExp(r'[0-9]')) ?? false);
    if (value == null || value == "") {
      return "Please Enter Fullname";
    } else if (found) {
      return "Full name should not contains numbers";
    } else if (value.length > 10) {
      return "Name is too big should contain less than 10 character";
    } else if (value.length < 3) {
      return "Name is too short";
    }
    return null;
  }

  String? validateBankAccNumber(String? value) {
    if (value == null || value == "") {
      return "Please Enter Bank Account Number";
    } else {
      final val = int.tryParse(value);
      if (value.trim().length != 8 || val == null) {
        return "Please Enter Valid Bank Account Number";
      }
    }
    return null;
  }

  String? validateAddressNo(String? value) {
    if (value == null || value == "") {
      return "Please Enter Address No ";
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value == "") {
      return "Please Enter Address";
    } else if (value.length > 100) {
      return "Address is too big";
    }
    return null;
  }
}
