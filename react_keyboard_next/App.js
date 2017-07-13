import React, { Component } from 'react';
import { AppRegistry, View, TextInput, Input} from 'react-native';
import { NativeModules, NativeEventEmitter } from 'react-native';
const { KeyboardUtilityBarInterface } = NativeModules;

// var kubi = NativeModules.KeyboardUtilityBarInterface;
// kubi.registerCallbacks((error, events) => {console.log("next")}, (error, events) => {console.log("cancel")})

const calendarManagerEmitter = new NativeEventEmitter(KeyboardUtilityBarInterface);

focused = null 

export default class UselessTextInputMultiline extends Component {
  constructor(props) {
    super(props);
    this.focused = ""
    this.state = {
      text: 'Useless Multiline Placeholder',
    };
    

const subscription = calendarManagerEmitter.addListener(
  'ClickEvent',
  (reminder) => {
    console.log(reminder.name)
    if (reminder.name == "Cancel") {
    	if (this.focused == "first") {
			this.refs.first.blur()
    	}
    	else {
			this.refs.second.blur()
		}
    }
    else if (reminder.name == "Next") {
    	if (this.focused == "first") {
			this.refs.second.focus()
    	}
    	else {
			this.refs.first.focus()
		}
    }
}
);
  }

  // If you type something in the text box that is a color, the background will change to that
  // color.
  render() {
    return (
     <View style={{
       borderBottomWidth: 1,
       marginTop: 100}}
     >       
       <TextInput rounded
                keyboardType={'numeric'}
                ref= {'first'}
              style={{ borderWidth: 1.3, borderColor: "#dfdfdf", borderRadius: 10, backgroundColor: "#fff", paddingTop: 10, paddingBottom: 10, paddingLeft: 20, paddingRight: 20, textAlignVertical: 'top',  marginTop: 0, height: 120}}
              placeholderTextColor={'#ddd'}
              multiline={true}
              numberOfLines={6}
              underlineColorAndroid="transparent"
              placeholder="Input extra details that will be pinned on top of the group for all members to be aware of."
              onChangeText={(details) => { this.onValueChange('details', details); }}
              onFocus={ () => { this.focused = 'first'; }}
              value={this.state.text}/>
       <TextInput rounded

                ref= {'second'}
                keyboardUp={false}
              style={{ borderWidth: 1.3, borderColor: "#dfdfdf", borderRadius: 10, backgroundColor: "#fff", paddingTop: 10, paddingBottom: 10, paddingLeft: 20, paddingRight: 20, textAlignVertical: 'top',  marginTop: 0, height: 120}}
              placeholderTextColor={'#ddd'}
              multiline={true}
              numberOfLines={6}
              underlineColorAndroid="transparent"
              placeholder="Input extra details that will be pinned on top of the group for all members to be aware of."
              onFocus={ () => { this.focused = 'second'; }}
              onChangeText={(details) => { this.onValueChange('details', details); }}
              value={this.state.text}/>
     </View>
    );
  }
}
