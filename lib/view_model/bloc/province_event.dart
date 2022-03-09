import 'package:equatable/equatable.dart';

abstract class ProvinceEvent extends Equatable {
  const ProvinceEvent();

  @override
  List<Object> get props => [];
}

class GetProvince extends ProvinceEvent {
  const GetProvince() : super();
}
