import QtQuick
import Quickshell.I3

import "../singletons/"

ListView {
	orientation: ListView.Horizontal
	clip: true
	spacing: Theme.spacing
	implicitWidth: contentWidth
	implicitHeight: Theme.barItemHeight

	model: I3.workspaces

	delegate: Rectangle {
		id: button

		required property var modelData

		readonly property var workspace: modelData
		readonly property bool valid: workspace !== null && workspace !== undefined

		width: Math.max(40, label.implicitWidth + 16)
		height: ListView.view.height

		radius: Theme.radius

		color: valid && workspace.focused ? Theme.primary : Theme.surface1

		Text {
			id: label

			anchors.centerIn: parent

			text: button.valid ? button.workspace.name : ""

			font.family: Theme.fontFamily
			font.pixelSize: Theme.fontSize

			color: button.valid && button.workspace.focused ? Theme.primaryForeground : Theme.surfaceForeground
		}

		MouseArea {
			anchors.fill: parent

			onClicked: button.workspace.activate()
		}
	}
}
