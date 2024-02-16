import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseImage0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref('nohat.png').getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or placeholder widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}

class FirebaseImage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref('woolyhat.png').getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or placeholder widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}

class FirebaseImage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref('tshirt.png').getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or placeholder widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}

class FirebaseImage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref('hoodie.png').getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or placeholder widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}

class FirebaseImage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref('shorts.png').getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or placeholder widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}

class FirebaseImage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref('trousers.png').getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or placeholder widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}

class FirebaseImage6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref('flipflops.png').getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or placeholder widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}

class FirebaseImage7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref('trainers.png').getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or placeholder widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Image.network(snapshot.data!);
      },
    );
  }
}
