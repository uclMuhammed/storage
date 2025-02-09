# Flutter Projesi Cache Yönetimi Sistemi

## 1. Cache Öncelik Seviyeleri (CachePriority)

```dart
enum CachePriority {
  low,     // Uzun süre cache'de kalabilir
  medium,  // Normal cache süresi
  high,    // Kısa cache süresi
  critical // Çok kısa cache süresi
}
```

## 2. Cache Yönetimi (SmartCacheManager)

- Singleton pattern kullanılarak tek bir instance üzerinden yönetiliyor
- Veriler `Map<String, CacheData>` yapısında tutuluyor
- Her veri için süre, öncelik ve kullanım istatistikleri tutuluyor

## 3. Cache Ayarları (CacheSettings)

```dart
final maxSize = 100;                           // Maksimum cache boyutu
final defaultTimeout = Duration(minutes: 5);    // Varsayılan timeout süresi
final criticalDataTimeout = Duration(minutes: 1); // Kritik veri timeout süresi
final cleanupInterval = Duration(minutes: 15);  // Temizlik aralığı
final maxMemoryUsage = 50 * 1024 * 1024;       // Maksimum bellek kullanımı (50 MB)
```

## 4. Kategori Servisinde Kullanımı

`getAll` metodunda `CachePriority.high` kullanılıyor:
```dart
final updatedCategories = await _categoryService.getAll(priority: CachePriority.high);
```

Bu sayede:
- Veriler önbellekte tutuluyor
- Sık kullanılan veriler hızlıca erişilebiliyor
- Gereksiz API çağrıları önleniyor

## 5. Akıllı Cache Özellikleri

- **Otomatik Temizlik:** Belirli aralıklarla eski verileri temizler
- **Bellek Yönetimi:** Maksimum bellek kullanımını kontrol eder
- **Öncelik Bazlı Saklama:** Önemli veriler daha uzun süre saklanır
- **Kullanım Bazlı Optimizasyon:** Sık kullanılan veriler öncelikli tutulur

## 6. Cache İşlemleri

- **Veri Ekleme:** `set` metodu ile
- **Veri Okuma:** `get` metodu ile
- **Veri Silme:** `invalidate` metodu ile
- **Akıllı Veri Alma:** `getOrFetch` metodu ile (cache'de yoksa API'dan alır)

## 7. Cache İstatistikleri

- Hit/miss oranları
- Ortalama erişim süreleri
- Bellek kullanımı
- Toplam öğe sayısı

## Faydaları

Bu sistem sayesinde:
1. API çağrıları azalır
2. Uygulama performansı artar
3. Veri tutarlılığı sağlanır
4. Bellek kullanımı optimize edilir

## Örnek Kullanım

```dart
// Cache'den veri alma
final cachedData = await cacheManager.get<T>(key);

// Cache'e veri ekleme
await cacheManager.set(
  key,
  data,
  priority: CachePriority.high,
);

// Akıllı veri alma (cache'de yoksa API'dan alır)
final data = await cacheManager.getOrFetch<T>(
  key,
  () => apiService.getData(),
  priority: CachePriority.high,
);
``` 