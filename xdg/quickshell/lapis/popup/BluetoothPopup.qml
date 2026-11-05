import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth

import "../singletons"
import "../components"

LapisPopupWindow {
	id: root
	implicitWidth: 300
	implicitHeight: 300

	StackView {
		id: pages
		//anchors.fill: parent
		initialItem: homePage
	}

	Component {
		id: homePage

		Page {
			ScrollView {
				anchors.fill: parent

				ColumnLayout {
					width: parent.width
					spacing: 12

					Label {
						text: "Connected devices"
						font.bold: true
						font.pixelSize: Theme.fontSize
						font.family: Theme.fontFamily
					}

					Repeater {
						model: ScriptModel {
							values: Bluetooth.devices.values.filter(d => d.connected)
						}

						delegate: Button {
							required property BluetoothDevice modelData

							Layout.fillWidth: true
							text: modelData.name + " - Disconnected"

							onClicked: modelData.disconnect()
						}
					}

					Label {
						text: "Bluetooth adapters"
						font.bold: true
						font.pixelSize: Theme.fontSize
						font.family: Theme.fontFamily
					}

					Repeater {
						model: Bluetooth.adapters

						delegate: Button {
							required property BluetoothAdapter modelData

							Layout.fillWidth: true
							text: modelData.name + " (" + modelData.adapterId + ")"
						}
					}
				}
			}
		}
	}
}
