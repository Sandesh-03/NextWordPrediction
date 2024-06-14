import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class PredictNextWordScreen extends StatefulWidget {
  const PredictNextWordScreen({super.key});

  @override
  State<PredictNextWordScreen> createState() => _PredictNextWordScreenState();
}

class _PredictNextWordScreenState extends State<PredictNextWordScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _predictedWord = '';

  final List<Map<String, dynamic>> locales = [
    {'name': 'ENGLISH', 'locale': 'english'},
    {'name': 'मराठी', 'locale': 'marathi'},
  ];

  void updateLanguage(String language) {
    setState(() {
      _predictedWord = '';
    });
    _onTextChanged();
  }

  Future<void> buildLanguageDialog(BuildContext context) async {
    final String? selectedLanguage = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Your Language'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(locales[index]['name']),
                    onTap: () {
                      Navigator.of(context).pop(locales[index]['locale']);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.blue,
                );
              },
              itemCount: locales.length,
            ),
          ),
        );
      },
    );

    if (selectedLanguage != null) {
      updateLanguage(selectedLanguage);
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    String inputText = _textEditingController.text.trim();
    if (inputText.isNotEmpty) {
      _predictNextWord(inputText, 'english'); // Default language is English
    } else {
      // Clear predicted word when input text is empty
      setState(() {
        _predictedWord = '';
      });
    }
  }

  Future<void> _predictNextWord(String inputText, String language) async {
    var url = Uri.parse('http://127.0.0.1:5001/predict_next_word_route');
    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "training_data": [inputText],
          "language": language,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          _predictedWord = responseData['predicted_word'];
        });
      } else {
        if (kDebugMode) {
          print('Failed to predict next word: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error predicting next word: $e');
      }
    }
  }

  void _copyPredictedWordToClipboard() {
    Clipboard.setData(ClipboardData(text: _predictedWord));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Predicted word copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predict Next Word', style:TextStyle(

        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your text...',
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  onChanged: (value) {
                    _onTextChanged();
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Predicted Word:',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  _predictedWord,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _copyPredictedWordToClipboard();
              },
              child: const Text('Copy Predicted Word'),
            ),

          ],
        ),

      ),
    );
  }
}

