import 'package:code95_final/Pages/filterPage/viewModel/FilterViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/CustomTextFormField.dart';
import '../../../components/DropDownMenu.dart';
import '../../../components/TextWidget.dart';
import '../../../utils/helpers/extension.dart';


class FilterView extends StatefulWidget {
   const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
   late FilterViewModel controller ;

   @override
  void initState() {
     controller = FilterViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      backgroundColor: Colors.white,
      //had to change to make the container color visible
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
                ///Header
                Row(
                  children: [
                    const Expanded(
                      flex: 6,
                      child: TextWidget(
                        title: "Query Builder",
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState((){
                              controller.showMore = true;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: HexColor.fromHex("#219653"),
                                  width: 1,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.add,
                                  color: HexColor.fromHex("#219653"),
                                ),
                              )),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                ///name and gender filtering bloc
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: HexColor.fromHex("#F7F7F7"),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: DropDownMenu(
                              dropDownValue: controller.dropdownValue,
                              list: controller.list,
                              onChanged: (value){
                                setState((){
                                  controller.dropdownValue = value ?? "";
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 2,
                            child: DropDownMenu(
                              dropDownValue: controller.dropdownEqualNAme,
                              list: controller.equalListAge(),
                              onChanged: (value){
                                setState((){
                                  controller.dropdownEqualNAme = value ?? "";
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        textInputType: controller.dropdownValue == 'Age' ? TextInputType.number : TextInputType.name,
                        isEnabled: true,
                        hint: controller.dropdownValue,
                        onChanged: (value) {
                          setState((){
                            if (value!.isEmpty ) {
                              controller.firstTextFieldValidated = true;
                            } else {
                              controller.firstTextFieldValidated = false;
                            }
                          });
                        },
                        onSaved: (value) {
                          controller.firstValue = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty ) {
                            return "You must enter some text";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ///And/or dropdown
                controller.showMore
                    ? Align(
                  alignment: AlignmentDirectional.topStart,
                  child: SizedBox(
                    width: 80,
                    child: DropDownMenu(
                      dropDownValue: controller.dropdownAndOr,
                      list: controller.andOrList,
                      onChanged: (value){
                        setState((){
                          controller.dropdownAndOr = value ?? "";
                        });
                      },
                    ),
                  ),
                ): const SizedBox(),
                ///Gender filtering bloc
                controller.showMore
                    ? const SizedBox(
                  height: 10,
                ): const SizedBox(),
                controller.showMore
                    ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                        color: HexColor.fromHex("#F7F7F7"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: DropDownMenu(
                                      dropDownValue: controller.dropdownGender,
                                      list: controller.genderList,
                                      onChanged: (value){
                                        setState((){
                                          controller.dropdownGender = value ?? "";
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: DropDownMenu(
                                      dropDownValue: controller.dropdownEqualGender,
                                      list: controller.equalListGender,
                                      onChanged: (value){
                                        setState((){
                                          controller.dropdownEqualGender = value ?? "";
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextField(
                                isEnabled: false,
                                hint: controller.dropdownGender,
                                onTap: () {},
                                onChanged: (value) {

                                },
                                onSaved: (value) {
                                },
                                validator: (value) {
                                  return null;
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState((){
                                controller.showMore = false;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor.fromHex("#EB5757"),
                                    width: 1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.clear,
                                    color: HexColor.fromHex("#EB5757"),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ))
                    : const SizedBox(),
                SizedBox(
                  height: controller.showMore ? 25 : 15,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .07,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10), // <-- Radius
                        ),
                        backgroundColor: HexColor.fromHex("#2D9CDB"),
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        controller.validateData();
                      },
                      child: SvgPicture.asset("assets/searchIcon.svg")
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
