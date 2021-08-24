import 'package:flutter/cupertino.dart';

abstract class Tile extends StatelessWidget{
  const Tile({
    required Key? key,
    required this.index, 
    required this.title, 
    required this.subtitle, 
    required this.unread, 
    required this.image
  }) : super(key: key);

  final int index;
  final String title;
  final String subtitle;
  final int unread;
  final String image;

  @override
  Widget build(BuildContext context);
}