import 'package:flutter/material.dart';
import 'package:miniprojectext/rnn.dart';
import 'package:miniprojectext/text_prediction.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Predict Next Word'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'With RNN'),
              Tab(text: 'Default'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PredictNextWordWithRNNScreen(),
            PredictNextWordScreen(),
          ],
        ),
      ),
    );
  }
}
