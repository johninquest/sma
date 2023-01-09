import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smapp/shared/snackbar_messages.dart';
import 'package:smapp/styles/colors.dart';
import '../../providers/request_provider.dart';
import '../../shared/lists.dart';
import '../../styles/style.dart';
import '../../utils/date_time_helper.dart';

class AddCasePage extends StatelessWidget {
  const AddCasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new case',
          style: appBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: AddCaseForm(),
      ),
    );
  }
}

class AddCaseForm extends StatefulWidget {
  const AddCaseForm({super.key});

  @override
  State<AddCaseForm> createState() => _AddCaseFormState();
}

class _AddCaseFormState extends State<AddCaseForm> {
  int _currentStep = 0;
  final _addCaseFormKey = GlobalKey<FormState>();
  final TextEditingController _registrationNr = TextEditingController();
  final TextEditingController _givenNames = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _pickedDate = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _problemDetails = TextEditingController();
  final TextEditingController _method = TextEditingController();
  final TextEditingController _solution = TextEditingController();

  String? _classNumber;
  String? _classLetter;
  String? _gender;
  String? _studentStatus;
  String? _problemCategory;

  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1970, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentDate) {
      setState(() {
        currentDate = picked;
        _pickedDate.text = DateTimeHelper().dateToCmrDateString(picked);
        _age.text = DateTimeHelper().ageFromDate(picked);
        // print('Picked date => $picked');
        // log('Age => $_age');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //  _pickedDate.text = DateTimeHelper().dateToCmrDateString(DateTime.now());
    _pickedDate.text = '--/--/----';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addCaseFormKey,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stepper(
                currentStep: _currentStep,
                onStepTapped: (index) => setState(() {
                  _currentStep = index;
                }),
                onStepContinue: () {
                  if (_currentStep != 4) {
                    setState(() => _currentStep++);
                  }
                },
                onStepCancel: () {
                  if (_currentStep != 0) {
                    setState(() => _currentStep--);
                  }
                },
                physics: const ClampingScrollPhysics(),
                steps: [
                  Step(
                      isActive: _currentStep >= 0,
                      title: const Text('Student information'),
                      content: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              margin: const EdgeInsets.only(bottom: 5.0),
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: TextFormField(
                                controller: _registrationNr,
                                enabled: true,
                                decoration: const InputDecoration(
                                    labelText: 'Registration number'),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                validator: (val) => val!.isEmpty
                                    ? 'Please enter registration number'
                                    : null,
                                /* onChanged: (val) => setState(() {
                  surname = val;
                }), */
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              margin: const EdgeInsets.only(bottom: 5.0),
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: TextFormField(
                                controller: _surname,
                                enabled: true,
                                decoration:
                                    const InputDecoration(labelText: 'Surname'),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                validator: (val) => val!.isEmpty
                                    ? 'Please enter surname'
                                    : null,
                                /* onChanged: (val) => setState(() {
                  surname = val;
                }), */
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              margin: const EdgeInsets.only(bottom: 5.0),
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: TextFormField(
                                controller: _givenNames,
                                enabled: true,
                                decoration: const InputDecoration(
                                    labelText: 'Given names'),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                validator: (val) => val!.isEmpty
                                    ? 'Please enter given names'
                                    : null,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  margin: const EdgeInsets.only(right: 10.0),
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Class number'),
                                    items: AppData().classNumberList,
                                    validator: (val) =>
                                        val == null ? 'Class number ?' : null,
                                    onChanged: (val) => setState(() {
                                      _classNumber = val as String?;
                                    }),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  margin: const EdgeInsets.only(left: 10.0),
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Letter'),
                                    items: AppData().classLetterList,
                                    /* validator: (val) =>
                          val == null ? 'Please select payment method' : null, */
                                    onChanged: (val) => setState(() {
                                      _classLetter = val as String?;
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: TextFormField(
                                      controller: _pickedDate,
                                      enabled: true,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          labelText: 'Date of birth'),
                                      onTap: () => _selectDate(context),
                                    )),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    margin: const EdgeInsets.only(left: 10.0),
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: TextFormField(
                                      controller: _age,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                          labelText: 'Age'),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            margin: const EdgeInsets.only(bottom: 5.0),
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: DropdownButtonFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Sex'),
                              items: AppData().genderList,
                              validator: (val) =>
                                  val == null ? ' Please enter sex?' : null,
                              onChanged: (val) => setState(() {
                                _gender = val as String?;
                              }),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            margin: const EdgeInsets.only(bottom: 5.0),
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: DropdownButtonFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Status'),
                              items: AppData().studentStatusList,
                              validator: (val) =>
                                  val == null ? ' Please select status?' : null,
                              onChanged: (val) => setState(() {
                                _studentStatus = val as String?;
                              }),
                            ),
                          ),
                        ],
                      )),
                  Step(
                      isActive: _currentStep >= 1,
                      title: const Text('Parent information'),
                      content: const Text(
                        'Still under construction!',
                        style: TextStyle(color: warnColor),
                      )),
                  Step(
                      isActive: _currentStep >= 2,
                      title: const Text('Problem'),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            margin: const EdgeInsets.only(bottom: 5.0),
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: DropdownButtonFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Category'),
                              items: AppData().problemCategoryList,
                              validator: (val) => val == null
                                  ? ' Please select category!'
                                  : null,
                              onChanged: (val) => setState(() {
                                _problemCategory = val as String?;
                              }),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              margin: const EdgeInsets.only(bottom: 5.0),
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: TextFormField(
                                controller: _problemDetails,
                                enabled: true,
                                decoration: const InputDecoration(
                                    labelText: 'Additional details'),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                maxLines: 3,
                                validator: (val) => val!.isEmpty
                                    ? 'Please enter problem details'
                                    : null,
                              )),
                        ],
                      )),
                  Step(
                    isActive: _currentStep >= 3,
                    title: const Text('Method'),
                    content: Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        margin: const EdgeInsets.only(bottom: 5.0),
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: TextFormField(
                          controller: _method,
                          enabled: true,
                          decoration:
                              const InputDecoration(labelText: 'Method'),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          maxLines: 3,
                          validator: (val) =>
                              val!.isEmpty ? 'Please enter method!' : null,
                        )),
                  ),
                  Step(
                    isActive: _currentStep >= 4,
                    title: const Text('Solution'),
                    content: Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        margin: const EdgeInsets.only(bottom: 5.0),
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: TextFormField(
                          controller: _solution,
                          enabled: true,
                          decoration:
                              const InputDecoration(labelText: 'Solution'),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          maxLines: 3,
                          validator: (val) =>
                              val!.isEmpty ? 'Please enter solution!' : null,
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CANCEL',
                          style: TextStyle(
                              letterSpacing: 1.0, color: textBlackColor)),
                      /* style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ), */
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () =>
                          SnackBarMessage().underConstruction(context),
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                            letterSpacing: 1.0, fontWeight: FontWeight.bold),
                      ),
                      /*  style: ElevatedButton.styleFrom(backgroundColor: myTeal), */
                    ),
                  )
                ],
              ),
              Container(
                child: Text(
                    'Request data => ${context.watch<RequestProvider>().reqData}' ??
                        ''),
              )
            ],
          )),
    );
  }
}
