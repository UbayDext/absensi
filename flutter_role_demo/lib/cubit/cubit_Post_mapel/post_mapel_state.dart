// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/post_pelajaran/post_pelajaran.dart';

class PostMapelState extends Equatable {
  final List<PostPelajaran> postMapelK;
  final bool isLoading;
  final String isError;

  const PostMapelState({
    this.postMapelK = const [],
    this.isLoading = false,
    this.isError = '',
  });

  @override
  List<Object> get props => [postMapelK, isLoading, isError];

  PostMapelState copyWith({
    List<PostPelajaran>? postMapelK,
    bool? isLoading,
    String? isError,
  }) {
    return PostMapelState(
      postMapelK: postMapelK ?? this.postMapelK,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}


