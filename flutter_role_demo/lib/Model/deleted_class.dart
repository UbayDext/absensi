import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';


class DeletedClass extends Equatable {
	const DeletedClass({this.success, this.message});

	final bool? success;
	final String? message;

	factory DeletedClass.fromMap(Map<String, Object?> data) => DeletedClass(
				success: data['success'] as bool?,
				message: data['message'] as String?,
			);

	Map<String, Object?> toMap() => {
				'success': success,
				'message': message,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeletedClass].
	factory DeletedClass.fromJson(String data) {
		return DeletedClass.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [DeletedClass] to a JSON string.
	String toJson() => json.encode(toMap());

	DeletedClass copyWith({
		bool? success,
		String? message,
	}) {
		return DeletedClass(
			success: success ?? this.success,
			message: message ?? this.message,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [success, message];
}
