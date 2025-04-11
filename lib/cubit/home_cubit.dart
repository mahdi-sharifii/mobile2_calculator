import 'package:bloc/bloc.dart';
import 'package:mobile2_calculator/main.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(text: "0", pText: '0'));

  void addChar(String char) {
    emit(state.copyWith(newPText: state.text));
    if (state.text == "0") {

      emit(state.copyWith(newText: char));
    } else {
      emit(state.copyWith(newText: state.text + char));
    }
  }


 void calculate(){
if(haveOper(state.text)){
  emit(state.copyWith(newText: calculator(state.text) ));
}

 }

void clear(){
    emit(state.copyWith(newText: "0"));
}

void pText(){
emit(state.copyWith(newText: state.pText));

}

}
