
import 'package:social_app/components/components.dart';

// void signOut(context){
//   CacheHelper.removeData(key: 'token').then((value) {
//     if(value)
//     {
//       navigateAndFinish(context, ShopLoginScreen());
//     }
//   });
// }


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
String uId = '';



