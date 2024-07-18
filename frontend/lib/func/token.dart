import "dart:convert";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

Codec<String, String> b64 = utf8.fuse(base64);

String base64Decode(String string) => b64.decode(string);
String base64Encode(dynamic object) => b64.encode(object);

Future<Map<String,dynamic>> decoding(String? jwt,String? cookie) async{
  if (jwt!.isEmpty||cookie!.isEmpty) return {};

  final Map<String, dynamic> parsed = jwtParsing(jwt);
  int date =  DateTime.now().millisecond;
  final current = (date / 1000).floor();
  
  if (parsed['exp'] > current){
    await cacheRefresh(jwt,cookie);
    return {
      "cachedInfo" : jwt,
      "parsed" : parsed
    };
  }

  return {};
}

Future<dynamic> cacheRefresh(String jwt,String cookie) async{
  if (jwt.isEmpty||cookie.isEmpty) return {};
  const storage = FlutterSecureStorage();

  try{
    await storage.delete(key : 'userToken');
    await storage.write(key : "userToken", value : jwt);
    await storage.delete(key : 'cookie');
    await storage.write(key : "cookie", value : cookie);
    return jwt;
  }catch(e){
    print("캐시 삭제 오류 : $e");
    return;
  }
}

Map<String, dynamic> jwtParsing (String jwt) {
  final payload = jwt.substring(jwt.indexOf('.') + 1, jwt.lastIndexOf('.'));
  final decodedToken = base64Decode(payload);
  return jsonDecode(decodedToken);
}