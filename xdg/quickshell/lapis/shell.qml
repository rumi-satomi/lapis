import Quickshell
import QtQuick

import "./bar"
import "./singletons"

ShellRoot {
	Component.onCompleted: {
		console.log("ShellRoot initialized")
		console.log("Keyboard:", KeyboardController.autoEnabled)
		console.log("Gestures:", GestureController.running)
	}

	TopBar {}
	BottomBar {}
}
