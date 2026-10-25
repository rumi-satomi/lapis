import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell

import "../singletons"

LapisPopup {
	id: root

	popupWidth: 300

	Text {
		text: "Settings"
		font.bold: true
		font.pixelSize: 16
		color: Theme.surfaceForeground
	}

	CheckBox {
		text: "Auto keyboard vertical"
		checked: Settings.autoKeyboardVertical

		onToggled: Settings.autoKeyboardVertical = checked

		contentItem: Text {
			text: parent.text
			font.family: Theme.fontFamily
			font.pixelSize: Theme.fontSize
			color: Theme.surfaceForeground

			leftPadding: parent.indicator.width + parent.spacing
			verticalAlignment: Text.AlignVCenter
		}
	}

	CheckBox {
		text: "Auto keyboard horizontal"
		checked: Settings.autoKeyboardHorizontal

		onToggled: Settings.autoKeyboardHorizontal = checked

		contentItem: Text {
			text: parent.text
			font.family: Theme.fontFamily
			font.pixelSize: Theme.fontSize
			color: Theme.surfaceForeground

			leftPadding: parent.indicator.width + parent.spacing
			verticalAlignment: Text.AlignVCenter
		}
	}

	CheckBox {
		text: "Enable gestures"
		checked: Settings.gesturesEnabled

		onToggled: Settings.gesturesEnabled = checked

		contentItem: Text {
			text: parent.text
			font.family: Theme.fontFamily
			font.pixelSize: Theme.fontSize
			color: Theme.surfaceForeground

			leftPadding: parent.indicator.width + parent.spacing
			verticalAlignment: Text.AlignVCenter
		}
	}
}
