class CryptoList {
  final int rank;
  final String symbol, name, id;
  final double priceUsd, changePercent24Hr, marketCapUsd;

  CryptoList({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.priceUsd,
    required this.changePercent24Hr,
    required this.marketCapUsd,
  });

  factory CryptoList.fromMapJson(Map<String, dynamic> jsonData) {
    return CryptoList(
      id: jsonData["id"],
      rank: int.parse(jsonData["rank"]),
      symbol: jsonData["symbol"],
      name: jsonData["name"],
      priceUsd: double.parse(jsonData["priceUsd"]),
      changePercent24Hr: double.parse(jsonData["changePercent24Hr"]),
      marketCapUsd: double.parse(jsonData["marketCapUsd"]),
    );
  }
}

