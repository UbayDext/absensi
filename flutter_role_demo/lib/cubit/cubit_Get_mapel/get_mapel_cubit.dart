import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_Get_mapel/get_mapel_state.dart';
import 'package:flutter_role_demo/data/service/Get_mapel_service.dart';

class GetMapelCubit extends Cubit<GetMapelState> {
  final GetMapelService getMapelService;
  GetMapelCubit({required this.getMapelService}) : super(const GetMapelState());

  Future<void> getAllMapel() async {
    emit(state.copyWith(ifLoading: true, ifError: ''));

    final result = await getMapelService.fetchMapel();

    result.fold(
      (error) {
        emit(state.copyWith(ifLoading: false, ifError: error));
      },
      (mapelList) {
        emit(state.copyWith(mapelData: mapelList, ifLoading: false));
      },
    );
  }
}
