import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell

import "../singletons"

PopupWindow {
	id: root

	required property Item anchorItem

	anchor.item: anchorItem
	anchor.rect.y: anchorItem.height

	implicitWidth: 200
	implicitHeight: content.implicitHeight + 24

	color: Theme.background
	visible: false

	Rectangle {
		anchors.fill: parent
		color: Theme.surface1
		radius: 8

		ColumnLayout {
			id: content

			anchors {
				left: parent.left
				right: parent.right
				top: parent.top
				margins: 12
			}

			spacing: 8

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
			}

			CheckBox {
				text: "Auto keyboard horizontal"
				checked: Settings.autoKeyboardHorizontal

				onToggled: Settings.autoKeyboardHorizontal = checked
			}

			CheckBox {
				text: "Enable gestures"
				checked: Settings.gesturesEnabled

				onToggled: Settings.gesturesEnabled = checked
			}
		}
	}

	function toggle() {
		visible = !visible
	}
}
