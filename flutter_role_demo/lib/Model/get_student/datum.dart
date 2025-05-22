import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

import 'classroom.dart';
import 'pelajaran.dart';
import 'user.dart';


class Datum extends Equatable {
	const Datum({
		this.id, 
		this.userId, 
		this.name, 
		this.pelajaranId, 
		this.classroomId, 
		this.date, 
		this.checkInTime, 
		this.checkOutTime, 
		this.status, 
		this.notes, 
		this.createdAt, 
		this.updatedAt, 
		this.user, 
		this.classroom, 
		this.pelajaran, 
	});

	final int? id;
	final String? userId;
	final String? name;
	final String? pelajaranId;
	final String? classroomId;
	final String? date;
	final String? checkInTime;
	final String? checkOutTime;
	final String? status;
	final dynamic notes;
	final DateTime? createdAt;
	final DateTime? updatedAt;
	final User? user;
	final Classroom? classroom;
	final Pelajaran? pelajaran;

	factory Datum.fromMap(Map<String, Object?> data) => Datum(
				id: data['id'] as int?,
				userId: data['user_id'] as String?,
				name: data['name'] as String?,
				pelajaranId: data['pelajaran_id'] as String?,
				classroomId: data['classroom_id'] as String?,
				date: data['date'] as String?,
				checkInTime: data['check_in_time'] as String?,
				checkOutTime: data['check_out_time'] as String?,
				status: data['status'] as String?,
				notes: data['notes'] as dynamic,
				createdAt: data['created_at'] == null
						? null
						: DateTime.parse(data['created_at']! as String),
				updatedAt: data['updated_at'] == null
						? null
						: DateTime.parse(data['updated_at']! as String),
				user: data['user'] == null
						? null
						: User.fromMap(data['user']! as Map<String, Object?>),
				classroom: data['classroom'] == null
						? null
						: Classroom.fromMap(data['classroom']! as Map<String, Object?>),
				pelajaran: data['pelajaran'] == null
						? null
						: Pelajaran.fromMap(data['pelajaran']! as Map<String, Object?>),
			);

	Map<String, Object?> toMap() => {
				'id': id,
				'user_id': userId,
				'name': name,
				'pelajaran_id': pelajaranId,
				'classroom_id': classroomId,
				'date': date,
				'check_in_time': checkInTime,
				'check_out_time': checkOutTime,
				'status': status,
				'notes': notes,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'user': user?.toMap(),
				'classroom': classroom?.toMap(),
				'pelajaran': pelajaran?.toMap(),
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
		String? userId,
		String? name,
		String? pelajaranId,
		String? classroomId,
		String? date,
		String? checkInTime,
		String? checkOutTime,
		String? status,
		dynamic notes,
		DateTime? createdAt,
		DateTime? updatedAt,
		User? user,
		Classroom? classroom,
		Pelajaran? pelajaran,
	}) {
		return Datum(
			id: id ?? this.id,
			userId: userId ?? this.userId,
			name: name ?? this.name,
			pelajaranId: pelajaranId ?? this.pelajaranId,
			classroomId: classroomId ?? this.classroomId,
			date: date ?? this.date,
			checkInTime: checkInTime ?? this.checkInTime,
			checkOutTime: checkOutTime ?? this.checkOutTime,
			status: status ?? this.status,
			notes: notes ?? this.notes,
			createdAt: createdAt ?? this.createdAt,
			updatedAt: updatedAt ?? this.updatedAt,
			user: user ?? this.user,
			classroom: classroom ?? this.classroom,
			pelajaran: pelajaran ?? this.pelajaran,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props {
		return [
				id,
				userId,
				name,
				pelajaranId,
				classroomId,
				date,
				checkInTime,
				checkOutTime,
				status,
				notes,
				createdAt,
				updatedAt,
				user,
				classroom,
				pelajaran,
		];
	}
}
