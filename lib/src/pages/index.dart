import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        elevation: 900,
        title: Center(
          child: Text('lets do video call',
              style:GoogleFonts.poiretOne(fontSize: 25,fontStyle:FontStyle.normal,fontWeight: FontWeight.bold,color: Colors.white )),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:35,right:35),
                          child: TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                          errorText:
                              _validateError ? 'Channel name is mandatory' : null,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Channel Name',
                      ),
                    ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top:15,left:80,right:80),
                          child: RaisedButton(
                            onPressed: onJoin,
                            child: Text('Join',
                                style:GoogleFonts.pangolin(fontSize: 20,fontStyle:FontStyle.normal,fontWeight: FontWeight.bold,color: Colors.white )),
                               shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            elevation: 100,
                            color: Colors.pinkAccent,
                            textColor: Colors.white,
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
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
