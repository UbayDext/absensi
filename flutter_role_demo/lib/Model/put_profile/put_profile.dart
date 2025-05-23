import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'data.dart';


class PutProfile extends Equatable {
	const PutProfile({this.success, this.message, this.data});

	final bool? success;
	final String? message;
	final Data? data;

	factory PutProfile.fromMap(Map<String, Object?> data) => PutProfile(
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
  /// Parses the string and returns the resulting Json object as [PutProfile].
	factory PutProfile.fromJson(String data) {
		return PutProfile.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [PutProfile] to a JSON string.
	String toJson() => json.encode(toMap());

	PutProfile copyWith({
		bool? success,
		String? message,
		Data? data,
	}) {
		return PutProfile(
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
