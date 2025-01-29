import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  List<String> myCategoryIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'travel',
  ];

  String iconSelected = 'entertainment';

  @override
  void initState() {
    super.initState();
    expenseController = TextEditingController();
    categoryController = TextEditingController();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // добавили GestureDetector для скрытия клавиатуры и unfocus
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Add Expenses',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              // красивый современный InputDecoration
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: expenseController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      CupertinoIcons.money_dollar,
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: categoryController,
                readOnly: true,
                onTap: () => {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    CupertinoIcons.list_bullet,
                    size: 20,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      CupertinoIcons.plus,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      bool isExpended = false;

                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.grey,
                                title: Text('Create a category',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                    )),
                                content: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        // controller: dateController,

                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Name',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        // controller: dateController,
                                        readOnly: true,
                                        onTap: () {
                                          setState(() {
                                            isExpended = !isExpended;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: const Icon(
                                              CupertinoIcons.chevron_down,
                                              size: 12),
                                          hintText: 'Icon',
                                          border: OutlineInputBorder(
                                              borderRadius: isExpended
                                                  ? const BorderRadius.vertical(
                                                      top: Radius.circular(12))
                                                  : BorderRadius.circular(12),
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                      isExpended
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          bottom:
                                                              Radius.circular(
                                                                  12))),
                                              //icons grid drop down
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            mainAxisSpacing: 5,
                                                            crossAxisSpacing:
                                                                5),
                                                    itemCount:
                                                        myCategoryIcons.length,
                                                    itemBuilder:
                                                        (context, int index) {
                                                      return GestureDetector(
                                                        onTap: () =>
                                                            setState(() {
                                                          iconSelected =
                                                              myCategoryIcons[
                                                                  index];
                                                        }),
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border: Border.all(
                                                                color: iconSelected ==
                                                                        myCategoryIcons[
                                                                            index]
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .transparent),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/${myCategoryIcons[index]}.png')),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        // controller: dateController,

                                        readOnly: true,
                                        onTap: () => {
                                          showDialog(
                                            context: context,
                                            builder: (ctx2) {
                                              return AlertDialog(
                                                content: ColorPicker(
                                                  pickerColor: Colors.blue,
                                                  onColorChanged: (value) {
                                                    setState(() {});
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Color',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          });
                    },
                  ),
                  hintText: 'Category',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (newDate != null) {
                    setState(() {
                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(newDate);
                      selectedDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    CupertinoIcons.time,
                    size: 20,
                  ),
                  hintText: 'Date',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 32),
              // адаптивные высота и ширина кнопки
              SizedBox(
                width: double.infinity,
                height: kBottomNavigationBarHeight,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
