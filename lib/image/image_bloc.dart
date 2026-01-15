import 'package:flutter_bloc/flutter_bloc.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<LoadProfileImage>((event, emit) async {
      emit(ImageLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(ImageLoaded(event.imageUrl));
    });
  }
}
