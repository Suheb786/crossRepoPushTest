class ObtainToken {
  final String identity;
  final String displayName;

  ObtainToken(this.identity, this.displayName);

  Map<String, String> toJson() {
    Map<String, String> map = <String, String>{};
    map['identity'] = identity;
    map['displayName'] = displayName;
    return map;
  }
}
