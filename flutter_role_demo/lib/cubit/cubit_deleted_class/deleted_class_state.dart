// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/Model/deleted_class.dart';

class DeleteClassState extends Equatable {
  const DeleteClassState({
    this.responseDeleted = const DeletedClass(),
    this.itLoading = false,
    this.iterror = '',
  });

  final DeletedClass responseDeleted;
  final bool itLoading;
  final String iterror;

  @override
  List<Object?> get props => [responseDeleted, itLoading, iterror];

  DeleteClassState copyWith({
    DeletedClass? responseDeleted,
    bool? itLoading,
    String? iterror,
  }) {
    return DeleteClassState(
      responseDeleted: responseDeleted ?? this.responseDeleted,
      itLoading: itLoading ?? this.itLoading,
      iterror: iterror ?? this.iterror,
    );
  }
}
