import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'datum.dart';


class GetStudent extends Equatable {
	const GetStudent({this.success, this.message, this.data});

	final bool? success;
	final String? message;
	final List<Datum>? data;

	factory GetStudent.fromMap(Map<String, Object?> data) => GetStudent(
				success: data['success'] as bool?,
				message: data['message'] as String?,
				data: (data['data'] as List<dynamic>?)
						?.map((e) => Datum.fromMap(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toMap() => {
				'success': success,
				'message': message,
				'data': data?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetStudent].
	factory GetStudent.fromJson(String data) {
		return GetStudent.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [GetStudent] to a JSON string.
	String toJson() => json.encode(toMap());

	GetStudent copyWith({
		bool? success,
		String? message,
		List<Datum>? data,
	}) {
		return GetStudent(
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
