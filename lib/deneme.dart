class Dashbord {
  final String warehousesname; // depo adı
  final int warehousesId; // depo id
  final String productName; // ürün adı
  final int productId; // ürün id
  final DateTime startDate; // tarih
  final DateTime endDate; // tarih
  final int
      dataCount; // belirlenen tarih aralığındaki verilerin işlenecek sayısı
  final String commercialname; // alım - satım - iade
  final int commercialrate; // alım - satım - iade  oranı
  final bool isPurchase; // alım
  final bool isSale; // satım
  final bool isReturn; // iade
  final int totalQuantity; // toplam miktar
  final double totalPrice; // toplam fiyat
  final int purchaseQuantity; // alım miktarı
  final double purchasePrice; // alım fiyatı
  final int saleQuantity; // satım miktarı
  final double salePrice; // satım fiyatı
  final int returnQuantity; // iade miktarı
  final double returnPrice; // iade fiyatı
  Dashbord({
    required this.warehousesname,
    required this.warehousesId,
    required this.productName,
    required this.productId,
    required this.startDate,
    required this.endDate,
    required this.dataCount,
    required this.isPurchase,
    required this.isSale,
    required this.isReturn,
    required this.totalQuantity,
    required this.totalPrice,
    required this.purchaseQuantity,
    required this.purchasePrice,
    required this.saleQuantity,
    required this.salePrice,
    required this.returnQuantity,
    required this.returnPrice,
    required this.commercialname,
    required this.commercialrate,
  });
}
