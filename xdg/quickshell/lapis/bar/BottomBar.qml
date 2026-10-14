import QtQuick
import QtQuick.Layouts
import Quickshell

import "../singletons/"

PanelWindow {
	id: topBar
	color: Theme.background
	implicitHeight: Theme.barHeight
	visible: DeviceState.phoneMode

	anchors {
		bottom: true
		left: true
		right: true
	}

	RowLayout {
		anchors.fill: parent
		spacing: Theme.spacing

		Workspaces {
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.minimumWidth: 100
		}
	}
}
