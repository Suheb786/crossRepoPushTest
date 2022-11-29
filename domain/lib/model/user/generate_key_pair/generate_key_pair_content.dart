class GenerateKeyPairContent {
  final String? privatePEM;
  final String? publicPEM;

  GenerateKeyPairContent({this.privatePEM, this.publicPEM});

  factory GenerateKeyPairContent.fromJson(Map<String, dynamic> json) => GenerateKeyPairContent(
        privatePEM: json["privatePEM"],
        publicPEM: json["publicPEM"],
      );

  Map<String, dynamic> toJson() => {
        "privatePEM": privatePEM,
        "publicPEM": publicPEM,
      };
}
