import QtQuick
import Quickshell.I3

import "../singletons"

Rectangle {
	id: addButton

	implicitWidth: 32
	implicitHeight: Theme.barItemHeight
	radius: Theme.radius
	color: Theme.surface1

	Text {
		anchors.centerIn: parent

		text: "+"
		font.family: Theme.fontFamily
		font.pixelSize: Theme.fontSize

		color: Theme.surfaceForeground
	}

	MouseArea {
		anchors.fill: parent

		onClicked: addButton.createWorkspace()
	}

	function createWorkspace() {
		const used = new Set()

		for (const workspace of I3.workspaces.values) {
			if (workspace && workspace.number > 0) used.add(workspace.number)
		}

		let number = 1

		while (used.has(number)) {
			number++
		}

		I3.dispatch("workspace number " + number)
	}
}
