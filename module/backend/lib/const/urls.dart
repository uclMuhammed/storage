// Base URL'i platformlara göre dinamik olarak belirle
// ignore_for_file: non_constant_identifier_names

String get apiBaseUrl => 'http://server.halilucel.net:14192';

// Diğer URL'leri fonksiyon olarak tanımla
String get StockTrackerUrl => '$apiBaseUrl/';
String get StockTrackerApiUrl => '${StockTrackerUrl}api';
String get StockTrackerAuthUrl => '${StockTrackerUrl}auth';
