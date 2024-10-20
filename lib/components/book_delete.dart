import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/book.dart';

class DeleteBookModal extends StatefulWidget {
  final VoidCallback onBookDeleted;
  final Book book;

  const DeleteBookModal(
      {super.key, required this.book, required this.onBookDeleted});

  @override
  _DeleteBookModalState createState() => _DeleteBookModalState();
}

class _DeleteBookModalState extends State<DeleteBookModal> {
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  Future<void> _deleteBook() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Llamada al servicio ApiService para eliminar el libro
      await _apiService.deleteBook(widget.book.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Libro eliminado correctamente')),
      );

      widget.onBookDeleted();

      Navigator.of(context).pop(); // Cierra el modal
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Estás seguro?'),
      content: const Text(
        'Esta acción no se puede deshacer. ¿Estás seguro de que quieres eliminar este libro?',
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _deleteBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Color del botón "Continuar"
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Continuar',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

void showDeleteBookModal(
    BuildContext context, Book book, VoidCallback onBookDeleted) {
  showDialog(
    context: context,
    builder: (context) => DeleteBookModal(
      book: book,
      onBookDeleted: onBookDeleted,
    ),
  );
}
