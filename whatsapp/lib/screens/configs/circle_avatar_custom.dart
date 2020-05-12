import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CircleAvatarCustom {
  String _currentImage = "";

  CircleAvatarCustom(String currentImage) {
    _currentImage = currentImage;
  }

  Widget LoadUploadImage(StorageUploadTask storageUploadTask) {
    return (storageUploadTask == null)
        ? (_currentImage.length > 0)
            ? LoadUrlImage(_currentImage)
            : _voidCircle()
        : StreamBuilder(
            stream: storageUploadTask.events,
            builder: (BuildContext c, AsyncSnapshot<StorageTaskEvent> s) {
              return (s.connectionState == ConnectionState.done ||
                      s.connectionState == ConnectionState.active)
                  ? _streamUrl(s.data.snapshot.ref.getDownloadURL().asStream())
                  : _loading(s.data.snapshot.bytesTransferred / 2,
                      s.data.snapshot.totalByteCount);
            });
  }

  StreamBuilder _streamUrl(Stream<dynamic> stream) {
    return StreamBuilder<dynamic>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data != null && _currentImage != snapshot.data) {
          _currentImage = snapshot.data;
          return LoadUrlImage(snapshot.data);
        }
        return _loading(0.5, 1);
      },
    );
  }

  Widget LoadUrlImage(String url) {
    double size = 200;
    return Image.network(url, fit: BoxFit.fill, height: size, width: size,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
      return (loadingProgress == null)
          ? _result(child)
          : _loading(
              loadingProgress.cumulativeBytesLoaded +
                  (loadingProgress.expectedTotalBytes / 2),
              loadingProgress.expectedTotalBytes);
    });
  }

  Widget _loading(bytesTransferred, total) {
    return _baseCircle(CircularProgressIndicator(
        value: total != null ? bytesTransferred / total : null));
  }

  Widget _result(Widget child) {
    return _baseCircle(ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: child,
    ));
  }

  Widget _baseCircle(Widget child) {
    return CircleAvatar(
        child: child, maxRadius: 100, backgroundColor: Colors.grey);
  }

  Widget _voidCircle() =>
      _baseCircle(Text("Sem Imagem", style: TextStyle(color: Colors.white)));
}
