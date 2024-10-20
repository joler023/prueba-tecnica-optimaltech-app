import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/book.dart';

class ApiService {
  final String apiUrl =
      "https://prueba-tecnica-optimaltech-back.onrender.com";

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse("$apiUrl/book/all"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Método para crear un nuevo libro
  Future<void> createBook(String title) async {
    final response = await http.post(
      Uri.parse("$apiUrl/book/create"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': title,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create book');
    }
  }

  // Método para actualizar un nuevo libro
  Future<void> updateBook(int id, String title) async {
    final response = await http.patch(
      Uri.parse("$apiUrl/book/update/$id"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': title,
      }),
    );

    if (response.statusCode < 200 || response.statusCode > 399) {
      throw Exception('Failed to update book');
    }
  }

  // Método para eliminar un libro
  Future<void> deleteBook(int id) async {
    final response = await http.delete(
      Uri.parse("$apiUrl/book/remove/$id"),
    );

    if (response.statusCode < 200 || response.statusCode > 399) {
      print("error ${json.decode(response.body)}");
      throw Exception('Failed to delete book');
    }
  }
}
