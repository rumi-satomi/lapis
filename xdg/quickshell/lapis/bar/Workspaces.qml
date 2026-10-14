import QtQuick
import QtQuick.Layouts
import Quickshell.I3

import "../singletons/"

ListView {
	orientation: ListView.Horizontal
	clip: true
	spacing: Theme.spacing

	model: I3.workspaces

	delegate: Rectangle {
		id: button

		required property var modelData
		property var workspace: modelData

		width: Math.max(40, label.implicitWidth + 16)
		height: 24

		radius: Theme.radius

		color: workspace.focused ? Theme.primary : Theme.surface1

		Text {
			id: label

			anchors.centerIn: parent

			text: button.workspace.name

			font.family: Theme.fontFamily
			font.pixelSize: Theme.fontSize

			color: button.workspace.focused ? Theme.primaryForeground : Theme.surfaceForeground
		}

		MouseArea {
			anchors.fill: parent

			onClicked: button.workspace.activate()
		}
	}
}
