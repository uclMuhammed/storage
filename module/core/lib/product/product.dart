// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Urun {
  String isim;
  String barkod;
  int miktar;
  DateTime uretimtarihi;
  DateTime sontuketimtarihi;
  String partino;
  Urun({
    required this.isim,
    required this.barkod,
    required this.miktar,
    required this.uretimtarihi,
    required this.sontuketimtarihi,
    required this.partino,
  });

  Urun copyWith({
    String? isim,
    String? barkod,
    int? miktar,
    DateTime? uretimtarihi,
    DateTime? sontuketimtarihi,
    String? partino,
  }) {
    return Urun(
      isim: isim ?? this.isim,
      barkod: barkod ?? this.barkod,
      miktar: miktar ?? this.miktar,
      uretimtarihi: uretimtarihi ?? this.uretimtarihi,
      sontuketimtarihi: sontuketimtarihi ?? this.sontuketimtarihi,
      partino: partino ?? this.partino,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isim': isim,
      'barkod': barkod,
      'miktar': miktar,
      'uretimtarihi': uretimtarihi.millisecondsSinceEpoch,
      'sontuketimtarihi': sontuketimtarihi.millisecondsSinceEpoch,
      'partino': partino,
    };
  }

  factory Urun.fromMap(Map<String, dynamic> map) {
    return Urun(
      isim: map['isim'] as String,
      barkod: map['barkod'] as String,
      miktar: map['miktar'] as int,
      uretimtarihi:
          DateTime.fromMillisecondsSinceEpoch(map['uretimtarihi'] as int),
      sontuketimtarihi:
          DateTime.fromMillisecondsSinceEpoch(map['sontuketimtarihi'] as int),
      partino: map['partino'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Urun.fromJson(String source) =>
      Urun.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Urun(isim: $isim, barkod: $barkod, miktar: $miktar, uretimtarihi: $uretimtarihi, sontuketimtarihi: $sontuketimtarihi, partino: $partino)';
  }

  @override
  bool operator ==(covariant Urun other) {
    if (identical(this, other)) return true;

    return other.isim == isim &&
        other.barkod == barkod &&
        other.miktar == miktar &&
        other.uretimtarihi == uretimtarihi &&
        other.sontuketimtarihi == sontuketimtarihi &&
        other.partino == partino;
  }

  @override
  int get hashCode {
    return isim.hashCode ^
        barkod.hashCode ^
        miktar.hashCode ^
        uretimtarihi.hashCode ^
        sontuketimtarihi.hashCode ^
        partino.hashCode;
  }
}
