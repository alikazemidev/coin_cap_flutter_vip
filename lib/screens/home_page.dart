import 'package:crypto_vip/data/constant/constants.dart';
import 'package:crypto_vip/model/crypto_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'crypto_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.png'),
        SizedBox(
          height: 10,
        ),
        SpinKitWave(
          color: greenColor,
          size: 30,
        )
      ],
    ));
  }

  void _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<CryptoList> cryptoList = response.data["data"]
        .map<CryptoList>((jsonData) => CryptoList.fromMapJson(jsonData))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CryptoListPage(
          cryptoList: cryptoList,
          getData: _getData,
        ),
      ),
    );
  }
}
