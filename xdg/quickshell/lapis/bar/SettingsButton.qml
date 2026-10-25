import QtQuick
import "../singletons"
import "../popup"

Rectangle {
	id: root

	implicitWidth: label.implicitWidth + 16
	implicitHeight: Theme.barItemHeight

	radius: Theme.radius
	color: Theme.surface1

	Text {
		id: label

		anchors.centerIn: parent

		text: "⚙"
		font.family: Theme.fontFamily
		font.pixelSize: Theme.fontSize

		color: Theme.surfaceForeground
	}

	MouseArea {
		anchors.fill: parent
		onClicked: settingsPopup.toggle()
	}

	SettingsPopup {
		id: settingsPopup
		anchorItem: root
	}
}
