import 'package:dong/backend/repository/factor/utils/from_json.dart';
import 'package:dong/backend/repository/user/utils/from_json.dart';
import 'package:dong/data/entities.dart';

extension GroupFromJson on Group {
  static Group fromJson(Map<String, dynamic> data) {
    return Group(
      data['id'],
      data['name'] ?? "",
      UserFromJson.fromJson(data['creator']),
      data['subscribers']
              ?.map<User>((e) => UserFromJson.fromJson(e))
              ?.toList() ??
          [],
      data['factors']
              ?.map<Factor>((e) => FactorFromJson.fromJson(e))
              ?.toList() ??
          [],
    );
  }
}
