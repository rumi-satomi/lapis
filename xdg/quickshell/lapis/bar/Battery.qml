import QtQuick
import QtQuick.Layouts

import "../singletons/"

Rectangle {
	implicitWidth: batteryBody.implicitWidth + 64
	implicitHeight: batteryBody.implicitHeight + 12

	radius: Theme.radius
	color: Theme.surface1

	RowLayout {
		id: root

		spacing: 6
		anchors.centerIn: parent

		readonly property real level: UpsService.percentage
		readonly property color fillColor: UpsService.charging ? Theme.primary : (level <= 20 ? Theme.error : Theme.surfaceForeground)

		Rectangle {
			id: batteryBody

			implicitWidth: 28
			implicitHeight: 14

			radius: 3
			color: "transparent"
			border.width: 1
			border.color: Theme.surfaceForeground

			Rectangle {
				x: 3
				y: 3

				width: (batteryBody.width - 6) * Math.max(0, Math.min(1, root.level / 100))
				height: batteryBody.height - 6
				radius: 1

				color: root.fillColor

				Behavior on width {
					NumberAnimation {
						duration: 200
					}
				}
			}

			Text {
				anchors.centerIn: parent
				visible: UpsService.charging
				text: "⚡"

				font.family: Theme.fontFamily
				font.pixelSize: 12
				color: Theme.primaryForeground
			}
		}

		Rectangle {
			implicitWidth: 3
			implicitHeight: 6
			radius: 1
			color: Theme.surfaceForeground

			Layout.leftMargin: -6
		}

		Text {
			text: UpsService.available ? Math.round(root.level) + "%" : "--%"

			color: root.fillColor
			font.family: Theme.fontFamily
			font.pixelSize: Theme.fontSize
		}
	}
}
