import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictNextWordWithRNNScreen extends StatefulWidget {
  const PredictNextWordWithRNNScreen({super.key});

  @override
  State<PredictNextWordWithRNNScreen> createState() => _PredictNextWordWithRNNScreenState();
}

class _PredictNextWordWithRNNScreenState extends State<PredictNextWordWithRNNScreen> {
  final TextEditingController _seedTextController = TextEditingController();
  final TextEditingController _numWordsController = TextEditingController();
  String _generatedText = '';

  Future<void> _generateText() async {
    String seedText = _seedTextController.text.trim();
    int numWords = int.tryParse(_numWordsController.text.trim()) ?? 3;

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/generate_text'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'seed_text': seedText, 'num_words': numWords}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _generatedText = data['generated_text'];
      });
    } else {
      // Handle error
      print('Failed to generate text: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Generation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _seedTextController,
              decoration: const InputDecoration(
                labelText: 'Seed Text',
                hintText: 'Enter seed text...',
              ),
            ),
            TextField(
              controller: _numWordsController,
              decoration: const InputDecoration(
                labelText: 'Number of Words',
                hintText: 'Enter number of words...',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateText,
              child: const Text('Generate Text'),
            ),
            SizedBox(height: 20),
            const Text(
              'Generated Text:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _generatedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

