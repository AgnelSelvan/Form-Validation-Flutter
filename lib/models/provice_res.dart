import 'province.dart';

class ProvinceResponse {
  List<Province>? provinsi;

  ProvinceResponse({this.provinsi});

  ProvinceResponse.fromJson(Map<String, dynamic> json) {
    if (json['provinsi'] != null) {
      provinsi = <Province>[];
      json['provinsi'].forEach((v) {
        provinsi!.add(Province.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (provinsi != null) {
      data['provinsi'] = provinsi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
