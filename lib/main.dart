import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile2_calculator/cubit/home_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const List myList = [
      "1",
      "2",
      "3",
      "+",
      "4",
      "5",
      "6",
      "-",
      "7",
      "8",
      "9",
      "*",
      "00",
      "0",
      ".",
      "/"
    ];
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Calculator"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: AspectRatio(
                  aspectRatio: 4.1,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (p, c) => p.text != c.text,
                    builder: (context, state) {
                      return Container(


                        decoration: BoxDecoration(   color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 4)
                        ),
                        alignment: Alignment.center,

                        child: AutoSizeText(
                          state.text,
                          style: TextStyle(fontSize: 25),
                          maxLines: 1,
                        ),
                      );
                    },
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 10 / 2.55,
                child: Row(
                  children: [
                    CustomBTN(
                        onTap: () {
                          BlocProvider.of<HomeCubit>(context).calculate();
                        },
                        text: "=",
                        aspectRatio: 2 / 1, size: 25,),
                    CustomBTN(onTap: () {
                      BlocProvider.of<HomeCubit>(context).pText();

                    }, text: "Back", aspectRatio: 1, size: 15,),
                    CustomBTN(onTap: (

                        ) {
                      BlocProvider.of<HomeCubit>(context).clear();

                    }, text: "Clear", aspectRatio: 1, size: 15,),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 16,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return CustomBTN(
                    onTap: () {
                      final HomeCubit cubit =
                          BlocProvider.of<HomeCubit>(context);
                      if (haveOper(myList[index])) {
                        if (haveOper(cubit.state.text)) {
                          cubit.calculate();
                        }
                      }
                        cubit.addChar(myList[index]);

                    },
                    text: myList[index],
                    aspectRatio: 1,
                    color: Colors.black, size: 25,
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }
}

String calculator(String data) {
  num first = 0;
  num sec = 0;

  if (data.contains("+")) {
    final List<String> myList = data.split("+");

    first = num.parse(myList.first);
    sec = num.parse(myList.last);

    return (first + sec).toString();
  } else if (data.contains("-")) {
    final List<String> myList = data.split("-");

    first = num.parse(myList.first);
    sec = num.parse(myList.last);

    return (first - sec).toString();
  } else if (data.contains("*")) {
    final List<String> myList = data.split("*");

    first = num.parse(myList.first);
    sec = num.parse(myList.last);

    return (first * sec).toString();
  } else if (data.contains("/")) {
    final List<String> myList = data.split("/");

    first = num.parse(myList.first);
    sec = num.parse(myList.last);

    if (first == 0 || sec == 0) return "INFINITY";
    return (first / sec).toString();
  }

  return "NO DATA";
}

bool haveOper(String data) {
  if (data.contains("/"))
    return true;
  else if (data.contains("*"))
    return true;
  else if (data.contains("+"))
    return true;
  else if (data.contains("-")) return true;

  return false;
}

class CustomBTN extends StatelessWidget {
  const CustomBTN(
      {super.key,
      required this.onTap,
      required this.text,
      required this.aspectRatio,
      this.color = Colors.orange, required this.size,});

  final double aspectRatio;
  final VoidCallback onTap;
  final String text;
  final Color color;
final double size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 20,
            backgroundColor: color,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: size),
          ),
        ),
      ),
    );
  }
}
