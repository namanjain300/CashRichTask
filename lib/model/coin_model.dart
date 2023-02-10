import 'dart:convert';

class Coin {
  String name;
  String symbol;
  int rank;
  double price;
  double change24hPercent;

  Coin({
    required this.name,
    required this.symbol,
    required this.rank,
    required this.price,
    required this.change24hPercent,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'symbol': symbol,
      'cmc_rank': rank,
      'price': price,
      'percent_change_24h': change24hPercent,
    };
  }

  factory Coin.fromMap(Map<String, dynamic> map) {
    return Coin(
      name: map['name'] ?? '',
      symbol: map['symbol'] ?? '',
      rank: map['cmc_rank']?.toInt() ?? 0,
      price: map['quote']['USD']['price']?.toDouble() ?? 0.0,
      change24hPercent:
          map['quote']['USD']['percent_change_24h']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coin.fromJson(source) => Coin.fromMap(source);
}
