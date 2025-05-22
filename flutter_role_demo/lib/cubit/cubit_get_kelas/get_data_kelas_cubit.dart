import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_get_kelas/get_data_kelas_state.dart';
import 'package:flutter_role_demo/data/service/get_kelas_service.dart';

class GetDataKelasCubit extends Cubit<GetDataKelasState> {
  final GetKelasService classroomService;

  GetDataKelasCubit({required this.classroomService})
      : super(const GetDataKelasState());

  Future<void> getAllKelas() async {
    emit(state.copyWith(isLoading: true, isError: ''));

    final result = await classroomService.getAllClassrooms();

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, isError: error)),
      (kelasList) => emit(
        state.copyWith(classData: kelasList, isLoading: false),
      ),
    );
  }

  void resetState() => emit(const GetDataKelasState());
}

