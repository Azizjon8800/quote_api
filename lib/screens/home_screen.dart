import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quoteapp_api/models/quote_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<QuoteDataModel?> _quoteFuture;

  @override
  void initState() {
    super.initState();
    _quoteFuture = hitQuoteApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quotes',
          style: TextStyle(
            fontSize: 22,
            shadows: [Shadow(color: Colors.blueAccent, blurRadius: 5)],
          ),
        ),
        backgroundColor: Colors.yellow.shade100,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/quote.png'),
        ),
        actions: const [
          Icon(
            Icons.notifications_none_rounded,
            size: 30,
            color: Colors.black,
            shadows: [Shadow(color: Colors.blueAccent, blurRadius: 5)],
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        shadowColor: Colors.black,
        elevation: 11,
      ),
      backgroundColor: Colors.blueAccent.shade100,
      body: FutureBuilder<QuoteDataModel?>(
        future: _quoteFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Ошибка: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (snapshot.hasData) {
            final quotes = snapshot.data!.quotes;
            return ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      quotes[index].quote,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    subtitle: Text(
                      quotes[index].author,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Image.asset(
                      'assets/images/quote.png',
                      height: 40,
                      width: 40,
                    ),
                    trailing: const Icon(
                      Icons.favorite_border_rounded,
                      size: 30,
                    ),
                    tileColor: Colors.yellow.shade100.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Нет данных'));
        },
      ),
    );
  }

  Future<QuoteDataModel?> hitQuoteApi() async {
    try {
      const String url = "https://dummyjson.com/quotes";
      final Uri uri = Uri.parse(url);
      final http.Response res = await http.get(uri);
      if (res.statusCode == 200) {
        final resData = jsonDecode(res.body) as Map<String, dynamic>;
        return QuoteDataModel.fromJson(resData);
      } else {
        debugPrint('Ошибка: ${res.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Ошибка API: $e');
      return null;
    }
  }
}