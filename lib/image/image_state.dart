abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final String imageUrl;
  ImageLoaded(this.imageUrl);
}

class ImageError extends ImageState {
  final String message;
  ImageError(this.message);
}
