import 'package:flutter/material.dart';

import '../api_service.dart';

class CreateBookModal extends StatefulWidget {
  final VoidCallback onBookCreated;

  const CreateBookModal({super.key, required this.onBookCreated});

  @override
  _CreateBookModalState createState() => _CreateBookModalState();
}

class _CreateBookModalState extends State<CreateBookModal> {
  bool _isLoading = false;
  final ApiService _apiService = ApiService(); // Instancia del servicio de API
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: "");
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
        await _apiService.createBook(_titleController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Libro creado correctamente')),
        );

        widget.onBookCreated();

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
      title: const Text('Crear Libro'),
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
                  : const Text(
                      'Crear',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

void showCreateBookModal(BuildContext context, VoidCallback onBookCreated) {
  showDialog(
    context: context,
    builder: (context) => CreateBookModal(onBookCreated: onBookCreated),
  );
}
