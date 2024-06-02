class Farmer {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? dob;
  final String? panchayatCentre;
  final String? gender;
  final String? frnNumber;
  final String? role;
  final String? address;
  final bool? isAccountVerified;
  final bool? approved;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<String>? farmPhotos;
  final List<String>? tags;
  final String? imageUrl;
  final String? certification;
  final String? cropHarvestRecords;
  final String? landOwnership;
  final String? soilHealthReport;

  Farmer({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.dob,
    this.panchayatCentre,
    this.gender,
    this.frnNumber,
    this.role,
    this.address,
    this.isAccountVerified,
    this.approved,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.farmPhotos,
    this.tags,
    this.imageUrl,
    this.certification,
    this.cropHarvestRecords,
    this.landOwnership,
    this.soilHealthReport,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
      panchayatCentre: json['panchayat_centre'] as String?,
      gender: json['gender'] as String?,
      frnNumber: json['frn_number'] as String?,
      role: json['role'] as String?,
      address: json['address'] as String?,
      isAccountVerified: json['isAccountVerified'] as bool?,
      approved: json['approved'] as bool?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
      farmPhotos: (json['FarmPhotos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String?,
      certification: json['Certification'] as String?,
      cropHarvestRecords: json['CropHarvestRecords'] as String?,
      landOwnership: json['LandOwnership'] as String?,
      soilHealthReport: json['SoilHealthReport'] as String?,
    );
  }
}
