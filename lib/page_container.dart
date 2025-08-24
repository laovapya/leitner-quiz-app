import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  final Widget child;
  final bool hasBackArrow;
  final VoidCallback? onBackPressed;

  const PageContainer({
    required this.hasBackArrow,
    this.onBackPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(""), //Leiter Quiz App
        centerTitle: true,
        leading: hasBackArrow
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  onBackPressed?.call();
                },
              )
            : null,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: child,
      ),
    );
  }
}
