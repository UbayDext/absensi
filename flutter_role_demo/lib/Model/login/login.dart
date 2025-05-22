import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'data.dart';


class Login extends Equatable {
	const Login({this.success, this.data, this.message});

	final bool? success;
	final Data? data;
	final String? message;

	factory Login.fromMap(Map<String, Object?> data) => Login(
				success: data['success'] as bool?,
				data: data['data'] == null
						? null
						: Data.fromMap(data['data']! as Map<String, Object?>),
				message: data['message'] as String?,
			);

	Map<String, Object?> toMap() => {
				'success': success,
				'data': data?.toMap(),
				'message': message,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Login].
	factory Login.fromJson(String data) {
		return Login.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Login] to a JSON string.
	String toJson() => json.encode(toMap());

	Login copyWith({
		bool? success,
		Data? data,
		String? message,
	}) {
		return Login(
			success: success ?? this.success,
			data: data ?? this.data,
			message: message ?? this.message,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [success, data, message];
}
