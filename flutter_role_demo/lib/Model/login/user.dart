import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';


class User extends Equatable {
	const User({
		this.id, 
		this.name, 
		this.role, 
		this.email, 
		this.emailVerifiedAt, 
		this.createdAt, 
		this.updatedAt, 
	});

	final int? id;
	final String? name;
	final String? role;
	final String? email;
	final dynamic emailVerifiedAt;
	final DateTime? createdAt;
	final DateTime? updatedAt;

	factory User.fromMap(Map<String, Object?> data) => User(
				id: data['id'] as int?,
				name: data['name'] as String?,
				role: data['role'] as String?,
				email: data['email'] as String?,
				emailVerifiedAt: data['email_verified_at'] as dynamic,
				createdAt: data['created_at'] == null
						? null
						: DateTime.parse(data['created_at']! as String),
				updatedAt: data['updated_at'] == null
						? null
						: DateTime.parse(data['updated_at']! as String),
			);

	Map<String, Object?> toMap() => {
				'id': id,
				'name': name,
				'role': role,
				'email': email,
				'email_verified_at': emailVerifiedAt,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
	factory User.fromJson(String data) {
		return User.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
	String toJson() => json.encode(toMap());

	User copyWith({
		int? id,
		String? name,
		String? role,
		String? email,
		dynamic emailVerifiedAt,
		DateTime? createdAt,
		DateTime? updatedAt,
	}) {
		return User(
			id: id ?? this.id,
			name: name ?? this.name,
			role: role ?? this.role,
			email: email ?? this.email,
			emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props {
		return [
				id,
				name,
				role,
				email,
				emailVerifiedAt,
				createdAt,
				updatedAt,
		];
	}
}
