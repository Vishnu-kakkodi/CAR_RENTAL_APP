class DocumentInfo {
  final String url;
  final DateTime uploadedAt;
  final String status;

  DocumentInfo({
    required this.url,
    required this.uploadedAt,
    required this.status,
  });

  factory DocumentInfo.fromJson(Map<String, dynamic> json) {
    return DocumentInfo(
      url: json['url'],
      uploadedAt: DateTime.parse(json['uploadedAt']),
      status: json['status'],
    );
  }
}

class UploadedDocuments {
  final DocumentInfo aadharCard;
  final DocumentInfo drivingLicense;

  UploadedDocuments({
    required this.aadharCard,
    required this.drivingLicense,
  });

  factory UploadedDocuments.fromJson(Map<String, dynamic> json) {
    return UploadedDocuments(
      aadharCard: DocumentInfo.fromJson(json['aadharCard']),
      drivingLicense: DocumentInfo.fromJson(json['drivingLicense']),
    );
  }
}
