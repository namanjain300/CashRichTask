import 'package:cashrich_task/controller/coinlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final coinListProvider =
        Provider.of<CoinListProvider>(context, listen: false);
    coinListProvider.getCoinData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final coinListProvider = Provider.of<CoinListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'CoinRich',
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: SafeArea(
        child: coinListProvider.loading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.pie_chart_outline_rounded,
                                color: Colors.yellow,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Show Chart',
                                style: TextStyle(color: Colors.yellow),
                              )
                            ],
                          ),
                          Text(
                            'Count: ${(coinListProvider.coinList.length).toString()}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: coinListProvider.coinList.length,
                        itemBuilder: (context, index) {
                          return coinListTile(
                            name: coinListProvider.coinList[index].name,
                            symbol: coinListProvider.coinList[index].symbol,
                            percentChange24h: coinListProvider
                                .coinList[index].change24hPercent,
                            price: coinListProvider.coinList[index].price,
                            rank: coinListProvider.coinList[index].rank,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Widget coinListTile({
    required String name,
    required String symbol,
    required double percentChange24h,
    required double price,
    required int rank,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(color: Colors.yellow, fontSize: 26),
              ),
              Row(
                children: [
                  percentChange24h.isNegative
                      ? const Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.arrow_upward,
                          color: Colors.green,
                        ),
                  Text(
                      '${(percentChange24h.abs().toStringAsFixed(2)).toString()}%'),
                ],
              ),
              Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(2)),
                  child: Text(symbol)),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: Text('Price  \$ ${(price.toStringAsFixed(2)).toString()}'),
            ),
            Expanded(
              child: Text('Rank  ${rank.toString()}'),
            ),
            const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.yellow,
                child: Icon(Icons.arrow_forward_rounded))
          ]),
        ],
      ),
    );
  }
}
