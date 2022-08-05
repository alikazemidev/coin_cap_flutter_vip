import 'package:crypto_vip/data/constant/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/crypto_list.dart';

class CryptoListPage extends StatefulWidget {
  List<CryptoList>? cryptoList;
  final VoidCallback? getData;

  CryptoListPage({Key? key, this.cryptoList, this.getData}) : super(key: key);

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
        List<CryptoList> freshData = await _getData();
        setState(() {
          widget.cryptoList = freshData;
        });
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
            return _getListTile(
              widget.cryptoList![index],
              index,
            );
          },
        ),
      ),
    );
  }

  Future<List<CryptoList>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<CryptoList> cryptoList = response.data["data"]
        .map<CryptoList>((jsonData) => CryptoList.fromMapJson(jsonData))
        .toList();

    return cryptoList;
  }

  Widget _getListTile(CryptoList crypto, int index) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(
          color: greenColor,
        ),
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(
          color: greyColor,
        ),
      ),
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            crypto.rank.toString(),
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
                  crypto.priceUsd.toStringAsFixed(2),
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  crypto.changePercent24Hr.toStringAsFixed(2),
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
  }

  Icon _getIconChangePercent(int index) {
    if (widget.cryptoList![index].changePercent24Hr <= 0) {
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
