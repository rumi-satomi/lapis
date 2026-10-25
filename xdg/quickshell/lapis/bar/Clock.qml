import QtQuick
import Quickshell

import "../singletons/"

Rectangle {
	implicitWidth: label.implicitWidth + 16
	implicitHeight: Theme.barItemHeight

	radius: Theme.radius
	color: Theme.surface1

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}

	Text {
		id: label

		anchors.centerIn: parent

		text: Qt.formatDateTime(clock.date, "HH:mm")

		font.family: Theme.fontFamily
		font.pixelSize: Theme.fontSize
		color: Theme.surfaceForeground
	}
}
