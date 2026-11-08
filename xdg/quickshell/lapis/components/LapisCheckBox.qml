import QtQuick
import QtQuick.Controls

import "../singletons"

CheckBox {
	id: root

	implicitHeight: Theme.fontSize

	indicator: Rectangle {
		id: indicatorBox

		implicitWidth: Theme.fontSize
		implicitHeight: Theme.fontSize

		x: root.leftPadding
		y: (root.height - height) / 2

		radius: 2

		color: root.checked ? Theme.primary : "transparent"

		border.width: 2
		border.color: root.checked ? Theme.primary : Theme.surfaceForeground

		Behavior on color {
			ColorAnimation {
				duration: 100
			}
		}

		Item {
			anchors.centerIn: parent

			width: Theme.fontSize / 2
			height: Theme.fontSize / 2
			visible: root.checked

			Rectangle {
				anchors.centerIn: parent
				width: Theme.fontSize / 2
				height: 2
				radius: 1
				rotation: 45
				color: Theme.primaryForeground
			}

			Rectangle {
				anchors.centerIn: parent
				width: Theme.fontSize / 2
				height: 2
				radius: 1
				rotation: -45
				color: Theme.primaryForeground
			}
		}

	}
	
	contentItem: Text {
		text: root.text

		font.family: Theme.fontFamily
		font.pixelSize: Theme.fontSize

		color: Theme.surfaceForeground

		verticalAlignment: Text.AlignVCenter
		leftPadding: root.indicator.width + root.spacing
	}
}
