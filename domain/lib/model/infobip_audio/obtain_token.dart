class ObtainToken {
  String? identity;
  String? displayName;
  String? applicationId;
  String? appKey;
  String? baseUrl;

  ObtainToken({this.identity, this.displayName, this.applicationId, this.appKey, this.baseUrl});

  Map<String, String> toJson() {
    Map<String, String> map = <String, String>{};
    map['identity'] = identity!;
    map['displayName'] = displayName!;
    map['applicationId'] = applicationId!;
    map['appKey'] = appKey!;
    map['baseUrl'] = baseUrl!;
    return map;
  }
}
