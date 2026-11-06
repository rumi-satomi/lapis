import QtQuick
import Quickshell

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

	LazyLoader {
		id: settingsLoader
		
		SettingsPopup {
			anchorItem: root
		}
	}

	MouseArea {
		anchors.fill: parent

		onClicked: {
			settingsLoader.active = true

			const popup = settingsLoader.item
			if (popup) popup.toggle()
		}
	}

}
