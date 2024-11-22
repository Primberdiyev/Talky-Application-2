class GetNameFromUrl {
  String getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);

    final filePath = uri.pathSegments.last;

    final decodedFilePath = Uri.decodeComponent(filePath);

    return decodedFilePath.split('/').last;
  }
}
