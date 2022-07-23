import 'package:code95_final/Pages/filterPage/viewModel/FilterViewModel.dart';
import 'package:flutter/material.dart';
import '../../../components/TextWidget.dart';

class ResultScreen extends StatefulWidget {
  final FilterViewModel viewModel;
  const ResultScreen({Key? key,required this.viewModel}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height *.1,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                  child: const Icon(Icons.arrow_back,size: 26,)
              ),
              const SizedBox(height: 25),
              const TextWidget(
                title: "Users",
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              (widget.viewModel.usersList != null && widget.viewModel.usersList.isNotEmpty) ?
                const SizedBox(height: 15) :
                SizedBox(height: MediaQuery.of(context).size.height *.3),

              widget.viewModel.usersList == null ?
              const Center(child: CircularProgressIndicator(color: Colors.orange)):
              (widget.viewModel.usersList.isNotEmpty ) ?
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: widget.viewModel.usersList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      height: MediaQuery.of(context).size.height *.09,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(start: 8.0),
                                child: CircleAvatar(
                                  radius: MediaQuery.of(context).size.height *.04,
                                  backgroundColor: Colors.white,
                                  child: Image.asset('assets/image_avatar.png',),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    title: widget.viewModel.usersList[index].fullName,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                  TextWidget(
                                    title: widget.viewModel.usersList[index].gender,
                                    fontSize: 17,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 15),
                            child: TextWidget(
                              title: "Age: ${widget.viewModel.usersList[index].age}",
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              )  :
              const Center(child: TextWidget(
                title: "No item match your filter",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
