import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ImageListScreen extends StatefulWidget {
  const ImageListScreen({super.key});

  @override
  State<ImageListScreen> createState() => ImageListScreenState();
}

class ImageListScreenState extends State<ImageListScreen> {
  List<Images> imageList = [];

  @override
  void initState() {
    super.initState();
    _getImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Photo Gallery App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return _imageList(imageList[index]);
        },
        separatorBuilder: (_, __) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }

  Widget _imageList(Images images) {
    return ListTile(
      leading: Image.network(
        images.thumbnailUrl,
        height: 120,
      ),
      title: Text(images.title),
    );
  }

  Future<void> _getImageList() async {
    setState(() {});
    imageList.clear();
    const String apiURL = 'https://jsonplaceholder.typicode.com/photos';
    Uri uri = Uri.parse(apiURL);
    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> jsonImageList = jsonDecode(response.body);
      //final jsonImageList = decodedData[''];

      for (Map<String, dynamic> img in jsonImageList) {
        Images images = Images(
          albumId: img['albumId'] ?? '',
          id: img['id'] ?? '',
          title: img['title'] ?? '',
          url: img['url'] ?? '',
          thumbnailUrl: img['thumbnailUrl'] ?? '',
        );

        imageList.add(images);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong...')),
      );
    }
    setState(() {});
  }
}

class Images {
  final int albumId, id;
  final String title, url, thumbnailUrl;

  Images({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });
}
