class GetNameFromUrl {
  String getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);

    String filePath = uri.pathSegments.last;

    String decodedFilePath = Uri.decodeComponent(filePath);

    String fileName = decodedFilePath.split('/').last;

    return fileName;
  }
}
