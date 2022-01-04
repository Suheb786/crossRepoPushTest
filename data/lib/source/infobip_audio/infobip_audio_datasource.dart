abstract class InfobipAudioDS {
  Future<bool> initInfobipAudio(String applicationId, String appKey, String baseUrl,Function(String) callback);

  Future<String> obtainToken(String identity, String displayName);
}