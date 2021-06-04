import '../model/book.dart';

List<Book> books = [
  Book(
    title: "Didn't I Say to Make My Abilities Average in the Next Life?! Vol. 12",
    author: 'FUNA',
    filename: 'Didnt%20I%20Say%20To%20Make%20My%20Abilities%20Average%20In%20The%20Next%20Life!%20Vol.%2012.epub',
    createdDate: DateTime.parse('2020-07-02'),
    userId: '',
  ),
  Book(
    title: 'I Shall Survive Using Potions',
    author: 'FUNA',
    filename: 'I%20Shall%20Survive%20Using%20Potions.epub',
    createdDate: DateTime.parse('2020-07-02'),
    userId: '60b02ca26af41',
  ),
];

List<Book> history = [
  Book(
    title: "Didn't I Say to Make My Abilities Average in the Next Life?! Vol. 12",
    author: 'FUNA',
    filename: 'Didnt%20I%20Say%20To%20Make%20My%20Abilities%20Average%20In%20The%20Next%20Life!%20Vol.%2012.epub',
    createdDate: DateTime.parse('2020-07-02'),
    userId: '60b02ca26af41',
  ),
];

Map<String, String> book = {
  'title': 'New Book',
  'author': 'Best Author',
  'id': '0'
};

Map<String, List<String>> chapters = {
  '1': ['Chapter 1', 'text1'],
  '2': ['Chapter 2', 'text1'],
  '3': ['Chapter 3', 'text1'],
  '4': ['Chapter 4', 'text1']
};

List<String> chapter = ['Chapter 1', 'text1'];

Map<String, String> shelf = {'name': 'Fav Series', 'author': 'Best Author',
  'id': '0'};

Map<String, String> club = {
  'name': 'Tea Time',
  'last_message': 'wow that was really cool',
  'id': '0'
};

Map<String, String> option = {
  'name': 'Settings',
  'description': 'various settings to change app behavior',
  'id': '0'
};

Map<String, String> internetBook = {
  'title': 'New Internet Book',
  'author': 'Cool Guy',
  'id': '0'
};