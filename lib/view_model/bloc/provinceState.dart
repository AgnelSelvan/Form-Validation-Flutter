import 'package:equatable/equatable.dart';
import 'package:registration/models/provice_res.dart';

abstract class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object> get props => [];
}

class Empty extends ProvinceState {}

class Loading extends ProvinceState {}

class Loaded extends ProvinceState {
  final ProvinceResponse provinceResponse;

  const Loaded(this.provinceResponse) : super();
}

class Error extends ProvinceState {
  final String message;

  const Error(this.message) : super();
}
