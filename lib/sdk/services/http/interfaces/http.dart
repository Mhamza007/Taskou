abstract class HTTP {
  Future<dynamic> get(
    String url, {
    Map<String, dynamic> queryParameters,
  });
  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
  });
  Future<dynamic> put(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
  });
  Future<dynamic> delete(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
  });
}
