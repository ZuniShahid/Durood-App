class CurrencyModel {
  final int? id;
  final String? name;
  final String? code;
  final String? symbol;

  CurrencyModel({
    this.id,
    this.name,
    this.code,
    this.symbol,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "symbol": symbol,
      };
}
