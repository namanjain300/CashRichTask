import 'package:cashrich_task/api/api_manager.dart';
import 'package:flutter/material.dart';

import '../model/coin_model.dart';

class CoinListProvider extends ChangeNotifier {
  List<Coin> coinList = [];
  bool loading = false;

  getCoinData(context) async {
    loading = true;

    Map<String, String> header = {
      'X-CMC_PRO_API_KEY': '27ab17d1-215f-49e5-9ca4-afd48810c149'
    };

    Map res = await ApiManager().httpGet(
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=BTC,ETH,LTC,ADA,ATOM,BCH,BNB',
      header,
    );
    if (res['data'] != null) {
      coinList.clear();
      res['data'].values.forEach((coin) {
        coinList.add(Coin.fromJson(coin));
      });
      coinList;
    }
    loading = false;

    notifyListeners();
  }
}
