import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/Model/get_mapel/datum.dart';

class GetMapelState extends Equatable {
  const GetMapelState({
    this.mapelData = const [],
    this.ifLoading = false,
    this.ifError = '',
  });

  final List<Datum> mapelData;
  final bool ifLoading;
  final String ifError;

  @override
  List<Object> get props => [mapelData, ifLoading, ifError];

  GetMapelState copyWith({
    List<Datum>? mapelData,
    bool? ifLoading,
    String? ifError,
  }) {
    return GetMapelState(
      mapelData: mapelData ?? this.mapelData,
      ifLoading: ifLoading ?? this.ifLoading,
      ifError: ifError ?? this.ifError,
    );
  }
}
