import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';


class Data extends Equatable {
	const Data({
		this.nama, 
		this.code, 
		this.startTime, 
		this.endTime, 
		this.classroomId, 
		this.updatedAt, 
		this.createdAt, 
		this.id, 
	});

	final String? nama;
	final String? code;
	final String? startTime;
	final String? endTime;
	final int? classroomId;
	final DateTime? updatedAt;
	final DateTime? createdAt;
	final int? id;

	factory Data.fromMap(Map<String, Object?> data) => Data(
				nama: data['nama'] as String?,
				code: data['code'] as String?,
				startTime: data['start_time'] as String?,
				endTime: data['end_time'] as String?,
				classroomId: data['classroom_id'] as int?,
				updatedAt: data['updated_at'] == null
						? null
						: DateTime.parse(data['updated_at']! as String),
				createdAt: data['created_at'] == null
						? null
						: DateTime.parse(data['created_at']! as String),
				id: data['id'] as int?,
			);

	Map<String, Object?> toMap() => {
				'nama': nama,
				'code': code,
				'start_time': startTime,
				'end_time': endTime,
				'classroom_id': classroomId,
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
		String? nama,
		String? code,
		String? startTime,
		String? endTime,
		int? classroomId,
		DateTime? updatedAt,
		DateTime? createdAt,
		int? id,
	}) {
		return Data(
			nama: nama ?? this.nama,
			code: code ?? this.code,
			startTime: startTime ?? this.startTime,
			endTime: endTime ?? this.endTime,
			classroomId: classroomId ?? this.classroomId,
			updatedAt: updatedAt ?? this.updatedAt,
			createdAt: createdAt ?? this.createdAt,
			id: id ?? this.id,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props {
		return [
				nama,
				code,
				startTime,
				endTime,
				classroomId,
				updatedAt,
				createdAt,
				id,
		];
	}
}
