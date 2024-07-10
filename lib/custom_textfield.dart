import 'package:flutter/material.dart';

customtextfield(TextEditingController controller){
  return  Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                   
                  },
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    hintText: 'Adding field',
                    hintStyle: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
              );
}