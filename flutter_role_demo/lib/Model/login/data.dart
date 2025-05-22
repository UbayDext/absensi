import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'user.dart';


class Data extends Equatable {
	const Data({this.accessToken, this.tokenType, this.user});

	final String? accessToken;
	final String? tokenType;
	final User? user;

	factory Data.fromMap(Map<String, Object?> data) => Data(
				accessToken: data['access_token'] as String?,
				tokenType: data['token_type'] as String?,
				user: data['user'] == null
						? null
						: User.fromMap(data['user']! as Map<String, Object?>),
			);

	Map<String, Object?> toMap() => {
				'access_token': accessToken,
				'token_type': tokenType,
				'user': user?.toMap(),
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
		String? accessToken,
		String? tokenType,
		User? user,
	}) {
		return Data(
			accessToken: accessToken ?? this.accessToken,
			tokenType: tokenType ?? this.tokenType,
			user: user ?? this.user,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [accessToken, tokenType, user];
}
