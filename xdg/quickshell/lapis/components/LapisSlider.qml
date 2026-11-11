import QtQuick
import QtQuick.Controls.Basic as Controls

import "../singletons"

Controls.Slider {
	id : root

	implicitHeight: Theme.fontSize

	hoverEnabled: true

	background: Rectangle {
		x: root.leftPadding + root.handle.width / 2
		y: root.topPadding + (root.availableHeight - height) / 2

		width: Math.max(0, root.availableWidth - root.handle.width)
		height: Theme.fontSize / 4

		radius: height / 2
		color: Theme.surfaceTint

		Rectangle {
			width: parent.width * root.visualPosition
			height: parent.height

			radius: parent.radius
			color: Theme.primary
		}
	}

	handle: Rectangle {
		x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
		y: root.topPadding + (root.availableHeight - height) / 2

		implicitWidth: Theme.fontSize
		implicitHeight: Theme.fontSize

		radius: width / 2
		color: Theme.primary

		border.width: 2
		border.color: Theme.primaryForeground

		scale: root.pressed ? 1.15 : 1.0

		Behavior on scale {
			NumberAnimation {
				duration: 120
				easing.type: Easing.OutCubic
			}
		}
	}

	opacity: enabled ? 1.0 : 0.4
}
