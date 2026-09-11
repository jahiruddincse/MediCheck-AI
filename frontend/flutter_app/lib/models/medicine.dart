class Medicine {
  String name;
  String activeIngredient;
  String strength;
  String dosageForm;
  String manufacturer;
  String batchNumber;
  String mfgDate;
  String expDate;
  String mrp;

  Medicine({
    required this.name,
    required this.activeIngredient,
    required this.strength,
    required this.dosageForm,
    required this.manufacturer,
    required this.batchNumber,
    required this.mfgDate,
    required this.expDate,
    required this.mrp,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['medicine_name'] ?? json['name'] ?? '',
      activeIngredient: json['active_ingredient'] ?? '',
      strength: json['strength'] ?? '',
      dosageForm: json['dosage_form'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      batchNumber: json['batch_number'] ?? '',
      mfgDate: json['mfg_date'] ?? '',
      expDate: json['expiry_date'] ?? json['exp_date'] ?? '',
      mrp: json['mrp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicine_name': name,
      'active_ingredient': activeIngredient,
      'strength': strength,
      'dosage_form': dosageForm,
      'manufacturer': manufacturer,
      'batch_number': batchNumber,
      'mfg_date': mfgDate,
      'expiry_date': expDate,
      'mrp': mrp,
    };
  }

  static Medicine sampleGlycomet() {
    return Medicine(
      name: 'Glycomet 500 SR',
      activeIngredient: 'Metformin Hydrochloride',
      strength: '500 mg',
      dosageForm: 'Sustained Release Tablet',
      manufacturer: 'USV Private Limited',
      batchNumber: 'PCM82491',
      mfgDate: '08/2024',
      expDate: '07/2027',
      mrp: '₹45.20',
    );
  }
}
