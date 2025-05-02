// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SelectedState extends Equatable {
  const SelectedState({
    this.selectedButton = const {},
  });

  final Map<String, bool?> selectedButton;

  @override
  List<Object> get props => [selectedButton];

  SelectedState copyWith({
    Map<String, bool?>? selectedButton,
  }) {
    return SelectedState(
      selectedButton: selectedButton ?? this.selectedButton,
    );
  }
}
