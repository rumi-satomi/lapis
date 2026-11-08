import QtQuick
import QtQuick.Layouts

import "../singletons"
import "../components"

LapisPopupWindow {
	id: root

	body: ColumnLayout {
		spacing: Theme.spacing

		Text {
			text: "Settings"
			font.bold: true
			font.family: Theme.fontFamily
			font.pixelSize: Theme.fontSize
			color: Theme.surfaceForeground
		}

		RowLayout {
			Layout.fillWidth: true
			
			Text {
				text: "Brightness"
				font.family: Theme.fontFamily
				font.pixelSize: Theme.fontSize
				color: Theme.surfaceForeground
			}

			Item {
				Layout.fillWidth: true
			}

			Text {
				text: BrightnessService.brightness + "%"
				font.family: Theme.fontFamily
				font.pixelSize: Theme.fontSize
				color: Theme.surfaceForeground
			}
		}

		LapisSlider {
			id: brightnessSlider

			Layout.fillWidth: true

			from: 1
			to: 100
			stepSize: 1

			enabled: BrightnessService.available
			value: BrightnessService.brightness
			onMoved: BrightnessService.setBrightness(value)
		}

		LapisCheckBox {
			text: "Auto keyboard vertical"
			checked: Settings.autoKeyboardVertical
			onToggled: Settings.autoKeyboardVertical = checked
		}

		LapisCheckBox {
			text: "Auto keyboard horizontal"
			checked: Settings.autoKeyboardHorizontal
			onToggled: Settings.autoKeyboardHorizontal = checked
		}

		LapisCheckBox {
			text: "Enable gestures"
			checked: Settings.gesturesEnabled
			onToggled: Settings.gesturesEnabled = checked
		}
	}
}
