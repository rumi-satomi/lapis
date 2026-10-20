import QtQuick
import Quickshell
import "../singletons"

Rectangle {
	id: root

	implicitWidth: 28
	implicitHeight: 24

	radius: Theme.radius
	color: Theme.surface1

	Text {
		anchors.centerIn: parent

		text: "Settings"
		font.family: Theme.fontFamily
		font.pixelSize: Theme.fontSize

		color: Theme.surfaceForeground
	}

	MouseArea {
		id: mouseArea

		anchors.fill: parent
		hoverEnabled: true

		onClicked: settingsPopup.toggle()
	}

	SettingsPopup {
		id: settingsPopup
		anchorItem: root
	}
}
