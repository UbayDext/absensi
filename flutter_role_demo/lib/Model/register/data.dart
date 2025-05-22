import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'user.dart';


class Data extends Equatable {
	const Data({this.user, this.token});

	final User? user;
	final String? token;

	factory Data.fromMap(Map<String, Object?> data) => Data(
				user: data['user'] == null
						? null
						: User.fromMap(data['user']! as Map<String, Object?>),
				token: data['token'] as String?,
			);

	Map<String, Object?> toMap() => {
				'user': user?.toMap(),
				'token': token,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
	factory Data.fromJson(String data) {
		return Data.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
	String toJson() => json.encode(toMap());

	Data copyWith({
		User? user,
		String? token,
	}) {
		return Data(
			user: user ?? this.user,
			token: token ?? this.token,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [user, token];
}
