// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const Map<String, String> DefaultHeader = {
  'Content-Type': 'application/json',
  'Accept': '*/*',
  // CORS için gerekli header'lar
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers':
      'Origin, X-Requested-With, Content-Type, Accept, Authorization, Secure-Code',
};

const Map<String, String> StockTrackerAuthHeader = {
  ...DefaultHeader,
  'Secure-Code': 'SecureCode 123456',
};

Map<String, String> HeaderWithToken(String token) {
  return {
    ...StockTrackerAuthHeader,
    'authorization': 'Bearer $token',
  };
}
