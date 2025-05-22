import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';


class Pelajaran extends Equatable {
	const Pelajaran({
		this.id, 
		this.classroomId, 
		this.nama, 
		this.code, 
		this.startTime, 
		this.endTime, 
		this.createdAt, 
		this.updatedAt, 
	});

	final int? id;
	final String? classroomId;
	final String? nama;
	final String? code;
	final String? startTime;
	final String? endTime;
	final DateTime? createdAt;
	final DateTime? updatedAt;

	factory Pelajaran.fromMap(Map<String, Object?> data) => Pelajaran(
				id: data['id'] as int?,
				classroomId: data['classroom_id'] as String?,
				nama: data['nama'] as String?,
				code: data['code'] as String?,
				startTime: data['start_time'] as String?,
				endTime: data['end_time'] as String?,
				createdAt: data['created_at'] == null
						? null
						: DateTime.parse(data['created_at']! as String),
				updatedAt: data['updated_at'] == null
						? null
						: DateTime.parse(data['updated_at']! as String),
			);

	Map<String, Object?> toMap() => {
				'id': id,
				'classroom_id': classroomId,
				'nama': nama,
				'code': code,
				'start_time': startTime,
				'end_time': endTime,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pelajaran].
	factory Pelajaran.fromJson(String data) {
		return Pelajaran.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Pelajaran] to a JSON string.
	String toJson() => json.encode(toMap());

	Pelajaran copyWith({
		int? id,
		String? classroomId,
		String? nama,
		String? code,
		String? startTime,
		String? endTime,
		DateTime? createdAt,
		DateTime? updatedAt,
	}) {
		return Pelajaran(
			id: id ?? this.id,
			classroomId: classroomId ?? this.classroomId,
			nama: nama ?? this.nama,
			code: code ?? this.code,
			startTime: startTime ?? this.startTime,
			endTime: endTime ?? this.endTime,
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
				classroomId,
				nama,
				code,
				startTime,
				endTime,
				createdAt,
				updatedAt,
		];
	}
}
