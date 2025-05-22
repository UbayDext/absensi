import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';


class KelasGet extends Equatable {
	const KelasGet({this.id, this.name, this.createdAt, this.updatedAt});

	final int? id;
	final String? name;
	final DateTime? createdAt;
	final DateTime? updatedAt;

	factory KelasGet.fromMap(Map<String, Object?> data) => KelasGet(
				id: data['id'] as int?,
				name: data['name'] as String?,
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
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [KelasGet].
	factory KelasGet.fromJson(String data) {
		return KelasGet.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [KelasGet] to a JSON string.
	String toJson() => json.encode(toMap());

	KelasGet copyWith({
		int? id,
		String? name,
		DateTime? createdAt,
		DateTime? updatedAt,
	}) {
		return KelasGet(
			id: id ?? this.id,
			name: name ?? this.name,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [id, name, createdAt, updatedAt];
}
