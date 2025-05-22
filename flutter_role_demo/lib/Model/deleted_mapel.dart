import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';


class DeletedMapel extends Equatable {
	const DeletedMapel({this.success, this.message});

	final bool? success;
	final String? message;

	factory DeletedMapel.fromMap(Map<String, Object?> data) => DeletedMapel(
				success: data['success'] as bool?,
				message: data['message'] as String?,
			);

	Map<String, Object?> toMap() => {
				'success': success,
				'message': message,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeletedMapel].
	factory DeletedMapel.fromJson(String data) {
		return DeletedMapel.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [DeletedMapel] to a JSON string.
	String toJson() => json.encode(toMap());

	DeletedMapel copyWith({
		bool? success,
		String? message,
	}) {
		return DeletedMapel(
			success: success ?? this.success,
			message: message ?? this.message,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [success, message];
}
