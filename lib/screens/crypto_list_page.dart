import 'package:crypto_vip/data/constant/constants.dart';
import 'package:flutter/material.dart';

class CryptoListPage extends StatefulWidget {
  final cryptoList;
  final VoidCallback? getData;

  const CryptoListPage({Key? key, this.cryptoList, this.getData})
      : super(key: key);

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Colors.white,
      backgroundColor: Colors.blue,
      strokeWidth: 4.0,
      onRefresh: () async {
        await Future<void>.delayed(const Duration(seconds: 2))
            .then((_) => widget.getData);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blackColor,
          centerTitle: true,
          title: Text(
            'کریپتو بازار',
            style: TextStyle(
              fontFamily: "mrb",
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: blackColor,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                widget.cryptoList![index].name,
                style: TextStyle(
                  color: greenColor,
                ),
              ),
              subtitle: Text(
                widget.cryptoList![index].symbol,
                style: TextStyle(
                  color: greyColor,
                ),
              ),
              leading: SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    widget.cryptoList![index].rank.toString(),
                    style: TextStyle(
                      color: greyColor,
                    ),
                  ),
                ),
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.cryptoList![index].priceUsd.toStringAsFixed(2),
                          style: TextStyle(
                            color: greyColor,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.cryptoList![index].changePercent24Hr
                              .toStringAsFixed(2),
                          style: TextStyle(
                            color: _getColorChangePercent24Hr(index),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    _getIconChangePercent(index)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _getIconChangePercent(int index) {
    if (widget.cryptoList[index].changePercent24Hr <= 0) {
      return Icon(
        Icons.trending_down,
        color: redColor,
        size: 24,
      );
    }
    return Icon(
      Icons.trending_up,
      color: greenColor,
      size: 24,
    );
  }

  Color _getColorChangePercent24Hr(int index) {
    return widget.cryptoList![index].changePercent24Hr <= 0
        ? Colors.red
        : greenColor;
  }
}
