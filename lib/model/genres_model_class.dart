class Genres {
  final int id;
  final String name;

  Genres(this.id, this.name);

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        json['id'] as int,
        json['name'] as String,
      );

  // Added toJson method
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
