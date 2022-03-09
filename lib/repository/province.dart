import 'package:dartz/dartz.dart';
import 'package:registration/core/error/exception.dart';
import 'package:registration/core/error/failures.dart';
import 'package:registration/core/network/network_info.dart';
import 'package:registration/data/data_source/province.dart';
import 'package:registration/models/provice_res.dart';

abstract class ProvinceRepository {
  Future<Either<Failure, ProvinceResponse>> getProvince();
}

class ProvinceRepositoryImpl extends ProvinceRepository {
  late ProvinceRemoteDataSourceImpl provinceRemoteDataSourceImpl;
  late NetworkInfo networkInfo;

  ProvinceRepositoryImpl({
    required ProvinceRemoteDataSourceImpl dataSourceImpl,
    required NetworkInfo info,
  }) {
    provinceRemoteDataSourceImpl = dataSourceImpl;
    networkInfo = info;
  }

  @override
  Future<Either<Failure, ProvinceResponse>> getProvince() async {
    if (await networkInfo.isConnected ?? false) {
      try {
        final prov = await provinceRemoteDataSourceImpl.getProvince();
        return Right(prov);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnknownFailure("$e"));
      }
    } else {
      throw ServerException("No Internet Connextion");
    }
  }
}
