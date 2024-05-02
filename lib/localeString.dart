import 'package:get/get.dart';

class LocaleString extends Translations{
  @override
 
  Map<String, Map<String, String>> get keys => {
     //ENGLISH LANGUAGE
    'en_US':{
      'hello':'Hello World',
      'hintText':'Enter your sentence...',
      'message':'Predicted Word:',
      'title':'wordcast',
      
      'changelang':'Change Language'
    },
     //Maeathi LANGUAGE
    'mr_IN':{
      'hello': 'नमस्ते दुनिया',
      'message':'अंदाजित शब्द:',
      'hintText':'तुमचे वाक्य टाका...',
      'title':'वर्डकास्ट',
      'changelang':'भाषा बदलो'
    },
   
  
  };

}