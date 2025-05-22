import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'data.dart';


class UpadateClass extends Equatable {
	const UpadateClass({this.success, this.message, this.data});

	final bool? success;
	final String? message;
	final Data? data;

	factory UpadateClass.fromMap(Map<String, Object?> data) => UpadateClass(
				success: data['success'] as bool?,
				message: data['message'] as String?,
				data: data['data'] == null
						? null
						: Data.fromMap(data['data']! as Map<String, Object?>),
			);

	Map<String, Object?> toMap() => {
				'success': success,
				'message': message,
				'data': data?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UpadateClass].
	factory UpadateClass.fromJson(String data) {
		return UpadateClass.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [UpadateClass] to a JSON string.
	String toJson() => json.encode(toMap());

	UpadateClass copyWith({
		bool? success,
		String? message,
		Data? data,
	}) {
		return UpadateClass(
			success: success ?? this.success,
			message: message ?? this.message,
			data: data ?? this.data,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [success, message, data];
}
