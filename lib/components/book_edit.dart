import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/book.dart';

class EditBookModal extends StatefulWidget {
  final VoidCallback onBookUpdated;
  final Book book;

  const EditBookModal(
      {super.key, required this.book, required this.onBookUpdated});

  @override
  _EditBookModalState createState() => _EditBookModalState();
}

class _EditBookModalState extends State<EditBookModal> {
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Usamos el servicio ApiService para crear el libro
        await _apiService.updateBook(widget.book.id, _titleController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Libro actualizado correctamente')),
        );

        widget.onBookUpdated();

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
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Libro'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Ingrese el título del libro',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El título no puede estar vacío';
                }
                if (value.length < 2) {
                  return 'El título debe tener al menos 2 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            const Text('El título de tu libro.'),
          ],
        ),
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
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Color del botón
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Guardar',
                      style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}

void showEditBookModal(
    BuildContext context, Book book, VoidCallback onBookUpdated) {
  showDialog(
    context: context,
    builder: (context) => EditBookModal(
      book: book,
      onBookUpdated: onBookUpdated,
    ),
  );
}
