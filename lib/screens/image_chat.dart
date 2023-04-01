import 'package:flutter/material.dart';
import 'package:open_ai/Controllers/SendMessageController.dart';
import 'package:open_ai/theme/AppTheme.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageChat extends StatefulWidget {
  const ImageChat({Key? key}) : super(key: key);

  @override
  State<ImageChat> createState() => _ImageChatState();
}

class _ImageChatState extends State<ImageChat> {
  List<Widget> messages = <Widget> [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final messageFieldController = TextEditingController();
    return Scaffold(
      appBar:AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('assets/images/black.png'),
                    width: 35,
                  )
              )
            ],
          )
      ),
      body: Container(
        color: AppTheme.define().primaryColor,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: messages,
                ),
              ),
              loading ? LinearProgressIndicator(
                color: AppTheme.define().accentColor,
              ) : SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.abc,
                        size: 35,
                      ),
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/chat');
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 70,
                      child: TextField(
                        controller: messageFieldController,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold
                        ),
                        decoration: InputDecoration(
                            fillColor: AppTheme.define().primaryColor,
                            hintText: 'Décrivez votre image',
                            filled: true,
                            hintStyle: TextStyle(
                                color: AppTheme.define().focusColor,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold
                            ),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                print(messageFieldController.text);
                                toMessage(context, messageFieldController.text);
                              },
                              icon: Icon(Icons.send, color: AppTheme.define().focusColor,),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> toMessage(context, String content) async {
    setState(() {
      messages.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                  ),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                      minWidth: MediaQuery.of(context).size.width * 0.5
                  ),
                  child: Text(
                    content,
                    style: TextStyle(
                        color: AppTheme.define().accentColor,
                        fontFamily: "Montserrat",
                        fontWeight:
                        FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          )
      );
      loading = true;
    });
    var message = await SendMessageController().sendImageMessage(content);

    fromMessage(context, message);
  }

  void fromMessage(context, content){
    setState(() {
      messages.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.define().accentColor
                  ),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                      minWidth: MediaQuery.of(context).size.width * 0.5
                  ),
                  child: Stack(
                    children: <Widget>[
                      Center(child: CircularProgressIndicator(color: AppTheme.define().accentColor)),
                      Center(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: content,
                          fit: BoxFit.fill,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      );
      loading = false;
    });
  }
}
