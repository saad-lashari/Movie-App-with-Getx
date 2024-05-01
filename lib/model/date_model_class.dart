class Dates {
  final String minimum;
  final String maximum;

  Dates({
    required this.minimum,
    required this.maximum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        minimum: json['minimum'] as String,
        maximum: json['maximum'] as String,
      );
}
