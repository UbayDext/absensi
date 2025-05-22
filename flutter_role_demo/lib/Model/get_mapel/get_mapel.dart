import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'datum.dart';


class GetMapel extends Equatable {
	const GetMapel({this.success, this.message, this.data});

	final bool? success;
	final String? message;
	final List<Datum>? data;

	factory GetMapel.fromMap(Map<String, Object?> data) => GetMapel(
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
  /// Parses the string and returns the resulting Json object as [GetMapel].
	factory GetMapel.fromJson(String data) {
		return GetMapel.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [GetMapel] to a JSON string.
	String toJson() => json.encode(toMap());

	GetMapel copyWith({
		bool? success,
		String? message,
		List<Datum>? data,
	}) {
		return GetMapel(
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
