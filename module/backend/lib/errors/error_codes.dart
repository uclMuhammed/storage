enum ApiErrorCode {
  // Kimlik Doğrulama Hataları (400-499)
  unauthorized(401, 'Yetkisiz erişim'),
  forbidden(403, 'Erişim reddedildi'),
  tokenExpired(401, 'Oturum süresi doldu'),
  invalidCredentials(401, 'Geçersiz kimlik bilgileri'),

  // Veri Hataları (400-499)
  invalidInput(400, 'Geçersiz girdi'),
  notFound(404, 'Kayıt bulunamadı'),
  duplicateEntry(409, 'Kayıt zaten mevcut'),
  validationError(422, 'Doğrulama hatası'),

  // Sunucu Hataları (500-599)
  internalError(500, 'Sunucu hatası'),
  serviceUnavailable(503, 'Servis kullanılamıyor'),
  databaseError(503, 'Veritabanı hatası'),
  networkError(503, 'Ağ hatası'),

  // İş Mantığı Hataları (600-699)
  insufficientStock(600, 'Yetersiz stok'),
  invalidOperation(601, 'Geçersiz işlem'),
  limitExceeded(602, 'Limit aşıldı'),

  // Bilinmeyen Hata
  unknown(999, 'Bilinmeyen hata');

  final int code;
  final String message;
  const ApiErrorCode(this.code, this.message);
}
