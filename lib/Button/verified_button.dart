import 'package:flutter/material.dart';


class VeriButton extends StatelessWidget {
  final String title ;
  final VoidCallback onTap ;
  final bool loading ;
  const VeriButton( {Key? key ,
    required this.title,
    required this.onTap,
    this.loading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: loading ? const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,
          ) :
          
        Text(title, style: const TextStyle(color: Colors.white),),),
      ),
    );
  }
}