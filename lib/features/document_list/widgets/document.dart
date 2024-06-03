import 'package:flutter/material.dart';
import 'package:my_app/repositories/models/document_list.dart';

class DocumentWidget extends StatelessWidget {
  final Document document;
  final VoidCallback onTap;

  const DocumentWidget({
    required this.document,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$document.createdAt',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              document.name,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
