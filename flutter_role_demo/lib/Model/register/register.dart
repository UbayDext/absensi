import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'data.dart';


class Register extends Equatable {
	const Register({this.success, this.message, this.data});

	final bool? success;
	final String? message;
	final Data? data;

	factory Register.fromMap(Map<String, Object?> data) => Register(
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
  /// Parses the string and returns the resulting Json object as [Register].
	factory Register.fromJson(String data) {
		return Register.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Register] to a JSON string.
	String toJson() => json.encode(toMap());

	Register copyWith({
		bool? success,
		String? message,
		Data? data,
	}) {
		return Register(
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
