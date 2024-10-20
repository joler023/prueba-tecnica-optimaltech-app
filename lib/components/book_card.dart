import 'package:flutter/material.dart';
import 'package:prueba_tecnica_optimal_tech_app/components/book_delete.dart';
import 'package:prueba_tecnica_optimal_tech_app/components/book_edit.dart';

import '../models/book.dart';

class BookCard extends StatelessWidget {
  final VoidCallback onBookUpdated;
  final Book book;

  const BookCard({super.key, required this.book, required this.onBookUpdated});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título del libro
          Text(
            book.title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8.0),
          
          // Fechas
          Text(
            'Creado: ${book.createdAt}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          Text(
            'Actualizado: ${book.updatedAt}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
          

          // Botones de editar y eliminar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                 icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: () {
                  showEditBookModal(context, book, onBookUpdated);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDeleteBookModal(context, book, onBookUpdated);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}