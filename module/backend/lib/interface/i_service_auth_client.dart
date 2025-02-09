abstract class IServiceAuthClient {
  Future<bool> login(int companyCode, String email, String password);
  Future<bool> isAuthenticated();
  Future<void> logout();
  Future<String?> getToken();
  Future<Map<String, String>> getAuthHeaders();
  Future<bool> signup(String companyName, String email, String password);
}
