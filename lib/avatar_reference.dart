class AvatarReference {
  final String downloadUrl;
  AvatarReference(this.downloadUrl);

  factory AvatarReference.fromMap(Map<String, dynamic> data) {
    if (data == null) return null;
    final String downloadUrl = data['downloadUrl'];
    if (downloadUrl == null) return null;
    return AvatarReference(downloadUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'downloadUrl': downloadUrl,
    };
  }
}
