import 'package:intl/intl.dart';

DateTime getDateTime(String string){
  try{
    final createdDate = DateTime.parse(string);
    return createdDate;
  } catch (e) {
    return DateTime.now();
  }
}
DateTime getMilisecondToDateTime(int milliseconds){
  return DateTime.fromMillisecondsSinceEpoch(milliseconds);
}
String getDateDiff(String string){
    DateTime createdAt = getDateTime(string);
    final date = DateTime.now();
    final compared = date.difference(createdAt);
    if (compared.inMinutes < 1) {
      return '방금 전';
    } else if (compared.inHours < 1) {
      return '${compared.inMinutes} 분전';
    } else if (compared.inDays < 1) {
      return '${compared.inHours} 시간 전';
    } else {
      return '${createdAt.year}.${createdAt.month}.${createdAt.day}';
    }
}
String getFutureDiff(String string){
    DateTime createdAt = getDateTime(string);
    final date = DateTime.now();
    final compared = createdAt.difference(date);
    if (compared.inMinutes < 1) {
      return '${compared.inSeconds}초';
    } else if (compared.inHours < 1) {
      return '${compared.inMinutes} 분';
    } else if (compared.inDays < 1) {
      return '${compared.inHours} 시간';
    } else if (compared.inMinutes > 0){
      return '${createdAt.year}.${createdAt.month}.${createdAt.day}';
    } else {
      return "err";
    }
}
String getDateFull(String string){
    DateTime createdAt = getDateTime(string);
    return DateFormat("yyyy년 MM월 dd일 hh시 mm분").format(createdAt);
}
String getDateOnly(String string){
    DateTime createdAt = getDateTime(string);
    return DateFormat("yyyy년 MM월 dd일").format(createdAt);
}
String getYearOnly(String string){
    DateTime createdAt = getDateTime(string);
    return DateFormat("yyyy년").format(createdAt);
}