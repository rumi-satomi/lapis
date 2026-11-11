import QtQuick
import "../singletons"
import "../popup"

Rectangle {
	id: root

	implicitWidth: label.implicitWidth + 16
	implicitHeight: Theme.barItemHeight

	radius: Theme.radius
	color: Theme.surfaceTint

	Text {
		id: label

		anchors.centerIn: parent

		text: "ᚼᛒ"
		font.family: Theme.fontFamily
		font.pixelSize: Theme.fontSize

		color: Theme.surfaceForeground
	}

	MouseArea {
		anchors.fill: parent
		onClicked: bluetoothPopup.toggle()
	}

	BluetoothPopup {
		id: bluetoothPopup
		anchorItem: root
	}
}
