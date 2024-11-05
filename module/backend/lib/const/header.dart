const stockApiHeader = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Secure-Code': '123456',
};

Map<String, String> headerWithToken(String token) {
  return stockApiHeader
    ..addAll({
      'Authorization': 'Bearer $token',
    });
}
