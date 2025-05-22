import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';


class Data extends Equatable {
	const Data({this.name, this.updatedAt, this.createdAt, this.id});

	final String? name;
	final DateTime? updatedAt;
	final DateTime? createdAt;
	final int? id;

	factory Data.fromMap(Map<String, Object?> data) => Data(
				name: data['name'] as String?,
				updatedAt: data['updated_at'] == null
						? null
						: DateTime.parse(data['updated_at']! as String),
				createdAt: data['created_at'] == null
						? null
						: DateTime.parse(data['created_at']! as String),
				id: data['id'] as int?,
			);

	Map<String, Object?> toMap() => {
				'name': name,
				'updated_at': updatedAt?.toIso8601String(),
				'created_at': createdAt?.toIso8601String(),
				'id': id,
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
		String? name,
		DateTime? updatedAt,
		DateTime? createdAt,
		int? id,
	}) {
		return Data(
			name: name ?? this.name,
			updatedAt: updatedAt ?? this.updatedAt,
			createdAt: createdAt ?? this.createdAt,
			id: id ?? this.id,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [name, updatedAt, createdAt, id];
}
