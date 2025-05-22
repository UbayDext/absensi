import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'data.dart';


class PutMapel extends Equatable {
	const PutMapel({this.success, this.message, this.data});

	final bool? success;
	final String? message;
	final Data? data;

	factory PutMapel.fromMap(Map<String, Object?> data) => PutMapel(
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
  /// Parses the string and returns the resulting Json object as [PutMapel].
	factory PutMapel.fromJson(String data) {
		return PutMapel.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [PutMapel] to a JSON string.
	String toJson() => json.encode(toMap());

	PutMapel copyWith({
		bool? success,
		String? message,
		Data? data,
	}) {
		return PutMapel(
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
