class ObtainToken {
  String? identity;
  String? displayName;

  ObtainToken({this.identity, this.displayName});

  Map<String, String> toJson() {
    Map<String, String> map = <String, String>{};
    map['identity'] = identity!;
    map['displayName'] = displayName!;
    return map;
  }
}
