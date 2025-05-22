import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';


class Data extends Equatable {
	const Data({
		this.userId, 
		this.name, 
		this.pelajaranId, 
		this.classroomId, 
		this.date, 
		this.checkInTime, 
		this.checkOutTime, 
		this.status, 
		this.notes, 
		this.updatedAt, 
		this.createdAt, 
		this.id, 
	});

	final int? userId;
	final String? name;
	final int? pelajaranId;
	final int? classroomId;
	final String? date;
	final String? checkInTime;
	final String? checkOutTime;
	final String? status;
	final String? notes;
	final DateTime? updatedAt;
	final DateTime? createdAt;
	final int? id;

	factory Data.fromMap(Map<String, Object?> data) => Data(
				userId: data['user_id'] as int?,
				name: data['name'] as String?,
				pelajaranId: data['pelajaran_id'] as int?,
				classroomId: data['classroom_id'] as int?,
				date: data['date'] as String?,
				checkInTime: data['check_in_time'] as String?,
				checkOutTime: data['check_out_time'] as String?,
				status: data['status'] as String?,
				notes: data['notes'] as String?,
				updatedAt: data['updated_at'] == null
						? null
						: DateTime.parse(data['updated_at']! as String),
				createdAt: data['created_at'] == null
						? null
						: DateTime.parse(data['created_at']! as String),
				id: data['id'] as int?,
			);

	Map<String, Object?> toMap() => {
				'user_id': userId,
				'name': name,
				'pelajaran_id': pelajaranId,
				'classroom_id': classroomId,
				'date': date,
				'check_in_time': checkInTime,
				'check_out_time': checkOutTime,
				'status': status,
				'notes': notes,
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
		int? userId,
		String? name,
		int? pelajaranId,
		int? classroomId,
		String? date,
		String? checkInTime,
		String? checkOutTime,
		String? status,
		String? notes,
		DateTime? updatedAt,
		DateTime? createdAt,
		int? id,
	}) {
		return Data(
			userId: userId ?? this.userId,
			name: name ?? this.name,
			pelajaranId: pelajaranId ?? this.pelajaranId,
			classroomId: classroomId ?? this.classroomId,
			date: date ?? this.date,
			checkInTime: checkInTime ?? this.checkInTime,
			checkOutTime: checkOutTime ?? this.checkOutTime,
			status: status ?? this.status,
			notes: notes ?? this.notes,
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
				userId,
				name,
				pelajaranId,
				classroomId,
				date,
				checkInTime,
				checkOutTime,
				status,
				notes,
				updatedAt,
				createdAt,
				id,
		];
	}
}
