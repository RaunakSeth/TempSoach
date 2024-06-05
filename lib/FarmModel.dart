import 'Farmer.dart';

class FormModel {
  final String? id;
  final String? cropType;
  final double? landArea;
  final double? expectedProduction;
  final double? issuePercent;
  final double? quantity;
  final double? vgfaUnitEq;
  final Farmer? farmer;
  final int? state;
  final List<dynamic>? remarks;
  final int? v;

  FormModel({
    this.id,
    this.cropType,
    this.landArea,
    this.expectedProduction,
    this.issuePercent,
    this.quantity,
    this.vgfaUnitEq,
    this.farmer,
    this.state,
    this.remarks,
    this.v,
  });

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      id: json['_id'] as String?,
      cropType: json['cropType'] as String?,
      landArea: (json['landArea'] as num?)?.toDouble(),
      expectedProduction: (json['expextedProduction'] as num?)?.toDouble(),
      issuePercent: (json['issuePercent'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      vgfaUnitEq: (json['vgfaUnitEq'] as num?)?.toDouble(),
      farmer: json['farmer'] != null ? Farmer.fromJson(json['farmer'] as Map<String, dynamic>) : null,
      state: json['state'] as int?,
      remarks: json['remarks'] as List<dynamic>?,
      v: json['__v'] as int?,
    );
  }
  bool isEmpty()
  {
    if(id!=null&&cropType!=null&& landArea!=null&&expectedProduction!=null&&issuePercent!=null&&quantity!=null&&vgfaUnitEq!=null&&farmer!=null&&state!=null&& remarks!=null&&v!=null)
      return false;
          return true;
  }
}
