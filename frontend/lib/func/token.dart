import "dart:convert";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

Future<Map<String,dynamic>> decoding(String? jwt,String? cookie) async{
  if (jwt!.isEmpty||cookie!.isEmpty) return {};

  final Map<String, dynamic> parsed = jwtParsing(jwt);
  int date =  DateTime.now().millisecondsSinceEpoch;
  final current = (date / 1000).floor();
  
  if (parsed['exp'] > current){
    await cacheRefresh(jwt,cookie);
    Map<String,dynamic> response = {
      "cachedInfo" : jwt,
      "parsed" : parsed
    };
    print(current);
    print(response);
    return response;
  }

  return {};
}

Future<dynamic> cacheRefresh(String jwt,String cookie) async{
  if (jwt.isEmpty||cookie.isEmpty) return {};
  const storage = FlutterSecureStorage();

  try{
    await storage.delete(key : 'userToken');
    await storage.write(key : "userToken", value : jwt);
    await storage.delete(key : 'refreshToken');
    await storage.write(key : "refreshToken", value : cookie);
    return jwt;
  }catch(e){
    print("캐시 삭제 오류 : $e");
    return;
  }
}

Map<String, dynamic> jwtParsing (String jwt) {
  if (jwt.isEmpty) return {};
  Base64Codec base64 = const Base64Codec();
  final payload = jwt.substring(jwt.indexOf('.') + 1, jwt.lastIndexOf('.')); 
  final normalize = base64.normalize(payload);
  final decodedToken = utf8.decode(base64.decode(normalize));
  return jsonDecode(decodedToken);
}