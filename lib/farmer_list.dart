class farmer_list {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String dob;
  final String panchayatCentre;
  final String gender;
  final String frnNumber;
  final String role;
  final String address;
  final bool isAccountVerified;
  final bool approved;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;
  final List<String>? farmPhotos;
  final List<String>? tags;
  final String? imageUrl;
  final String? certification;
  final String? cropHarvestRecords;
  final String? landOwnership;
  final String? soilHealthReport;

  farmer_list({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.dob,
    required this.panchayatCentre,
    required this.gender,
    required this.frnNumber,
    required this.role,
    required this.address,
    required this.isAccountVerified,
    required this.approved,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.farmPhotos,
    required this.tags,
    required this.imageUrl,
    required this.certification,
    required this.cropHarvestRecords,
    required this.landOwnership,
    required this.soilHealthReport,
  });

  factory farmer_list.fromJson(Map<String, dynamic> json) {
    return farmer_list(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      dob: json['dob'],
      panchayatCentre: json['panchayat_centre'],
      gender: json['gender'],
      frnNumber: json['frn_number'],
      role: json['role'],
      address: json['address'],
      isAccountVerified: json['isAccountVerified'],
      approved: json['approved'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
      farmPhotos: json['FarmPhotos'] != null ? List<String>.from(json['FarmPhotos']) : null,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      imageUrl: json['imageUrl'],
      certification: json['Certification'],
      cropHarvestRecords: json['CropHarvestRecords'],
      landOwnership: json['LandOwnership'],
      soilHealthReport: json['SoilHealthReport'],
    );
  }
}
