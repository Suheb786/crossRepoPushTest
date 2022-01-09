mixin CardProcessingRemoteDs {}

mixin CardProcessingLocalDs {
  /// Decrypt Card Number
  String decryptCard({required String cardNo});

  /// Decrypt Generate Block Pin
  String generateBlockPin({required String cardNo, required String pinCode});
}
