part of 'home_cubit.dart';

 class HomeState {
String pText;
   String text ;
   HomeState({required this.text,required this.pText});

   HomeState copyWith({String? newText, String? newPText}){
     return HomeState(text: newText??text, pText:newPText??pText);
   }

 }

