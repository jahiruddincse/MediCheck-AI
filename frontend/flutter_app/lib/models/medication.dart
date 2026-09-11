class Medication {
  final String id;
  final String name;
  final String activeIngredient;
  final String strength;
  final String dosage;
  final String purpose;
  final String addedDate;

  Medication({
    required this.id,
    required this.name,
    required this.activeIngredient,
    required this.strength,
    required this.dosage,
    required this.purpose,
    required this.addedDate,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      activeIngredient: json['active_ingredient'] ?? '',
      strength: json['strength'] ?? '',
      dosage: json['dosage'] ?? '',
      purpose: json['purpose'] ?? '',
      addedDate: json['added_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'active_ingredient': activeIngredient,
      'strength': strength,
      'dosage': dosage,
      'purpose': purpose,
      'added_date': addedDate,
    };
  }
}
