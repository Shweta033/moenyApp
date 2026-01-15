abstract class ImageEvent {}

class LoadProfileImage extends ImageEvent {
  final String imageUrl;
  LoadProfileImage(this.imageUrl);
}
