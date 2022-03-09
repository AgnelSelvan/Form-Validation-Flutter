import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration/repository/province.dart';
import 'package:registration/view_model/bloc/provinceState.dart';
import 'package:registration/view_model/bloc/province_event.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  late ProvinceRepositoryImpl provinceRepositoryImpl;

  ProvinceBloc({required this.provinceRepositoryImpl}) : super(Empty()) {
    on((event, emit) async {
      emit(Loading());
      if (event is GetProvince) {
        try {
          final succOrFail = await provinceRepositoryImpl.getProvince();
          succOrFail.fold(
              (l) => emit(Error(l.toString())), (r) async => emit(Loaded(r)));
        } catch (e) {
          emit(Error("$e"));
        }
      }
    });
  }
}
