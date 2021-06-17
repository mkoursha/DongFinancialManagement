import 'package:dong/backend/repository/user/utils/from_json.dart';
import 'package:dong/data/entities.dart';

extension FactorFromJson on Factor {
  static Factor fromJson(Map<String, dynamic> json) {
    return Factor(
      json['id'],
      UserFromJson.fromJson(json['buyer']),
      json['description'] ?? "",
      DateTime.tryParse(json['dateTime']) ?? DateTime.now(),
      json['goods']?.map<Good>((e) => GoodFromJson.fromJson(e))?.toList() ?? [],
    );
  }
}

extension GoodFromJson on Good {
  static Good fromJson(Map<String, dynamic> json) {
    return Good(
      json['id'],
      json['name'],
      json['unitPrice'].toDouble(),
      json['number'].toDouble(),
      json['consumers']
              ?.map<Consumer>((e) => ConsumerFromJson.fromJson(e))
              ?.toList() ??
          [],
    );
  }
}

extension ConsumerFromJson on Consumer {
  static Consumer fromJson(Map<String, dynamic> json) {
    return Consumer(
      number: json['number'].toDouble(),
      user: UserFromJson.fromJson(json['uid']),
      id: json['id'],
    );
  }
}
