import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'classroom.dart';


class Datum extends Equatable {
	const Datum({
		this.id, 
		this.classroomId, 
		this.nama, 
		this.code, 
		this.startTime, 
		this.endTime, 
		this.createdAt, 
		this.updatedAt, 
		this.classroom, 
	});

	final int? id;
	final String? classroomId;
	final String? nama;
	final String? code;
	final String? startTime;
	final String? endTime;
	final DateTime? createdAt;
	final DateTime? updatedAt;
	final Classroom? classroom;

	factory Datum.fromMap(Map<String, Object?> data) => Datum(
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
				classroom: data['classroom'] == null
						? null
						: Classroom.fromMap(data['classroom']! as Map<String, Object?>),
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
				'classroom': classroom?.toMap(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
	factory Datum.fromJson(String data) {
		return Datum.fromMap(json.decode(data) as Map<String, Object?>);
	}
  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
	String toJson() => json.encode(toMap());

	Datum copyWith({
		int? id,
		String? classroomId,
		String? nama,
		String? code,
		String? startTime,
		String? endTime,
		DateTime? createdAt,
		DateTime? updatedAt,
		Classroom? classroom,
	}) {
		return Datum(
			id: id ?? this.id,
			classroomId: classroomId ?? this.classroomId,
			nama: nama ?? this.nama,
			code: code ?? this.code,
			startTime: startTime ?? this.startTime,
			endTime: endTime ?? this.endTime,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
			classroom: classroom ?? this.classroom,
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
				classroom,
		];
	}
}
