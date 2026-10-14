import QtQuick
import Quickshell

import "../singletons/"

PanelWindow {
	id: topBar
	color: Theme.background
	implicitHeight: Theme.barHeight

	anchors {
		top: true
		left: true
		right: true
	}

	Loader {
		anchors.fill: parent

		sourceComponent: DeviceState.handheldMode ? handheldLayout : phoneLayout
	}

	Component {
		id: handheldLayout
		HandheldTopBar {}
	}

	Component {
		id: phoneLayout
		PhoneTopBar {}
	}
}
