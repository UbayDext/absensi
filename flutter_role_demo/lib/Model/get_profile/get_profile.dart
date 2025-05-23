import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'data.dart';


class GetProfile extends Equatable {
	const GetProfile({this.success, this.message, this.data});

	final bool? success;
	final String? message;
	final Data? data;

	factory GetProfile.fromMap(Map<String, Object?> data) => GetProfile(
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
  /// Parses the string and returns the resulting Json object as [GetProfile].
	factory GetProfile.fromJson(String data) {
		return GetProfile.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [GetProfile] to a JSON string.
	String toJson() => json.encode(toMap());

	GetProfile copyWith({
		bool? success,
		String? message,
		Data? data,
	}) {
		return GetProfile(
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
