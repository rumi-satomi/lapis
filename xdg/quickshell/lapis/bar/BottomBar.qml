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

		Workspaces {}

		CreateWorkspaceButton {}

		Item {
			Layout.fillWidth: true
		}
	}
}
