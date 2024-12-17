class AppConfig {
  final String baseUrl;
  final String oneSignalId;
  AppConfig(this.baseUrl, this.oneSignalId);

  AppConfig.fromJson(Map<Object, dynamic> map)
      : baseUrl = map["baseUrl"],
        oneSignalId = map["oneSignalId"];
}

enum ENV { dev, prod }
