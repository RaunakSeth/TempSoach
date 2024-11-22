class BankDetailsModel {
  final String bankName;
  final String accountHolderName;
  final String accountNumber;
  final String reEnterAccountNumber;
  final String ifscCode;

  // Constructor
  BankDetailsModel({
    required this.bankName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.reEnterAccountNumber,
    required this.ifscCode,
  });

  // Convert a BankDetailsModel object into a Map
  Map<String, String> toMap() {
    return {
      'bankName': bankName,
      'accountHolderName': accountHolderName,
      'accountNumber': accountNumber,
      'reEnterAccountNumber': reEnterAccountNumber,
      'ifscCode': ifscCode,
    };
  }

  // Create a BankDetailsModel object from a Map
  factory BankDetailsModel.fromMap(Map<String, String> map) {
    return BankDetailsModel(
      bankName: map['bankName'] ?? '',
      accountHolderName: map['accountHolderName'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      reEnterAccountNumber: map['reEnterAccountNumber'] ?? '',
      ifscCode: map['ifscCode'] ?? '',
    );
  }

  // String representation of the model
  @override
  String toString() {
    return 'BankDetailsModel(bankName: $bankName, accountHolderName: $accountHolderName, accountNumber: $accountNumber, reEnterAccountNumber: $reEnterAccountNumber, ifscCode: $ifscCode)';
  }
}