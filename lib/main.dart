import 'package:flutter/material.dart';
import 'package:test_one/ethereum_example.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late HDWallet wallet;

  @override
  void initState() {
    TrustWalletCoreLib.init();
    super.initState();
    String mnemonic =
        "rent craft script crucial item someone dream federal notice page shrug pipe young hover duty";
    wallet = HDWallet.createWithMnemonic(mnemonic);
  }

  Widget _exampleItem({
    required String name,
    required WidgetBuilder builder,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: builder));
      },
      child: Text(name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('wallet core example app'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(wallet.mnemonic()),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _exampleItem(
                    name: 'Ethereum',
                    builder: (_) {
                      return EthereumExample(wallet);
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                wallet.delete();
                wallet = HDWallet();
                setState(() {});
              },
              child: const Text("gen"),
            ),
          ],
        ),
      ),
    );
  }
}
