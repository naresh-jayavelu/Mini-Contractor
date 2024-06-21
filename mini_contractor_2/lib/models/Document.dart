class Document {
  final String file;
  final String documentTypeId;
  final bool isActive;

  Document({
    required this.file,
    required this.documentTypeId,
    required this.isActive,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      file: json['file'],
      documentTypeId: json['documentTypeId'],
      isActive: json['isActive'],
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'file': file,
      'documentTypeId': documentTypeId,
      'isActive': isActive,
    };
  }
}
