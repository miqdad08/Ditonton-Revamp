import 'package:equatable/equatable.dart';

import '../../domain/entities/genre.dart';


class GenreTvModel extends Equatable {
  const GenreTvModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreTvModel.fromJson(Map<String, dynamic> json) => GenreTvModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  GenreTv toEntity() {
    return GenreTv(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
