import 'package:flutter/material.dart';

class CryptoListPage extends StatefulWidget {
  final cryptoList;
  const CryptoListPage({Key? key, this.cryptoList}) : super(key: key);

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.cryptoList![index].name),
            subtitle: Text(widget.cryptoList![index].symbol),
            leading: SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  widget.cryptoList![index].rank.toString(),
                ),
              ),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cryptoList![index].priceUsd.toStringAsFixed(2),
                      ),
                      Text(
                        widget.cryptoList![index].changePercent24Hr
                            .toStringAsFixed(2),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _getIconChangePercent(index)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _getIconChangePercent(int index) {
    if (widget.cryptoList[index].changePercent24Hr <= 0) {
      return Icon(
        Icons.trending_down,
        color: Colors.red,
        size: 24,
      );
    }
    return Icon(
      Icons.trending_up,
      color: Colors.green,
      size: 24,
    );
  }
}
