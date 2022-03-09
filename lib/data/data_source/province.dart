import 'package:registration/data/remote/endpoints.dart';
import 'package:registration/data/remote/network.dart';
import 'package:registration/models/provice_res.dart';

abstract class ProvinceRemoteDataSource {
  final apiService = NetworkAPIService();
  final endPoints = EndPoints();
  Future<ProvinceResponse> getProvince();
}

class ProvinceRemoteDataSourceImpl extends ProvinceRemoteDataSource {
  @override
  Future<ProvinceResponse> getProvince() async {
    try {
      print("Making API Call...");
      final response = await apiService.getResponse(endPoints.getProvince);
      return ProvinceResponse.fromJson(response);
    } catch (e) {
      print("Error : $e");
      rethrow;
    }
  }
}
