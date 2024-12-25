// ignore_for_file: constant_identifier_names, non_constant_identifier_names

const Map<String, String> DefaultHeader = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
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
