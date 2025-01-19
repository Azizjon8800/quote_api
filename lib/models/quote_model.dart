class QuoteDataModel {
  List<Quotes> quotes;
  int total;
  int skip;
  int limit;

  QuoteDataModel({
    required this.quotes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory QuoteDataModel.fromJson(Map<String, dynamic> json) {
    return QuoteDataModel(
      quotes: (json['quotes'] as List<dynamic>)
          .map((item) => Quotes.fromJson(item))
          .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quotes': quotes.map((quote) => quote.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}

class Quotes {
  int id;
  String quote;
  String author;

  Quotes({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) {
    return Quotes(
      id: json['id'] as int,
      quote: json['quote'] as String,
      author: json['author'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }
}