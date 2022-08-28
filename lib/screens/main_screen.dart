import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/data.dart';
import '../objects/meal.dart';
import '../widgets/primary_button.dart';
import '../widgets/text_input.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late Meal _meal;
  final List<String> _correctIngredients = [];

  @override
  void initState() {
    _generateRandomMeal();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: false,
        title: const Text(
          'PasiQuiz',
          style: TextStyle(
            color: black,
          ),
        ),
        titleSpacing: 32.0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _correctIngredients.clear();
                  _generateRandomMeal();
                });
              },
              focusColor: darkGray.withOpacity(0.2),
              highlightColor: darkGray.withOpacity(0.2),
              splashColor: darkGray.withOpacity(0.2),
              icon: const Icon(
                Icons.refresh,
                color: black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              color: black,
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      _meal.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: primary,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  const Text(
                    'Skład:',
                    style: TextStyle(
                      color: white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _correctIngredients.contains(
                                _meal.ingredients[index].toLowerCase())
                            ? Text(
                                '\u2022 ${_meal.ingredients[index]}',
                                style: const TextStyle(
                                  color: white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const Text(
                                '---------------------',
                                style: TextStyle(
                                  color: white,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2.85,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8.0);
                      },
                      itemCount: _meal.ingredients.length,
                    ),
                  )
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              height: 192.0,
              padding: const EdgeInsets.symmetric(horizontal: 24.0) +
                  const EdgeInsets.only(bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextInput(
                    controller: _controller,
                    onSubmitted: (val) {
                      _onPressed();
                      _controller.clear();
                      _focusNode.requestFocus();
                    },
                    focusNode: _focusNode,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  PrimaryButton(
                    label: 'Dodaj',
                    onPressed: _onPressed,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _generateRandomMeal() {
    _meal = meals[Random().nextInt(meals.length)];
  }

  void _onPressed() {
    String ingredient = _controller.text.toLowerCase();
    setState(() {
      if (_meal.ingredients
          .map((item) => item.toLowerCase())
          .contains(ingredient)) {
        _correctIngredients.add(ingredient);
      } else if (ingredient.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: black,
            duration: Duration(seconds: 1),
            content: Text(
              'Błędny składnik',
              style: TextStyle(
                color: white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }
      _controller.text = '';
    });
  }
}
