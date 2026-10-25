import QtQuick
import QtQuick.Layouts
import Quickshell

import "../singletons"

PopupWindow {
	id: root

	required property Item anchorItem

	default property alias popupContent: contentColumn.data

	property int popupWidth: 300
	property int padding: 12
	property int slideDistance: 16

	property bool expanded: false
	property bool closing: false

	anchor.item: anchorItem
	anchor.rect.x: (anchorItem.width - implicitWidth) / 2
	anchor.rect.y: anchorItem.height + Theme.spacing

	//implicitWidth: popupWidth
	implicitWidth: contentColumn.implicitWidth + 2 * padding
	implicitHeight: contentColumn.implicitHeight + 2 * padding

	color: "transparent"
	grabFocus: false
	visible: false

	function open() {
		if (visible && !closing) return

		closing = false
		closeAnimation.stop()

		expanded = false
		visible = true

		openAnimation.start()
	}

	function close () {
		if (!visible || closing) return

		closing = true
		openAnimation.stop()
		closeAnimation.start()
	}

	function toggle() {
		if (visible && !closing) {
			close()
		} else {
			open()
		}
	}

	onVisibleChanged: {
		if (!visible) {
			openAnimation.stop()
			closeAnimation.stop()
			expanded = false
			closing = false
		}
	}

	Rectangle {
		id: panel

		width: parent.width
		height: parent.height

		radius: Theme.radius
		color: Theme.surface2

		y: root.expanded ? 0 : -root.slideDistance
		opacity: root.expanded ? 1 : 0

		ColumnLayout {
			id: contentColumn

			anchors.fill: parent
			anchors.margins: root.padding

			spacing: Theme.spacing
		}
	}

	ParallelAnimation {
		id: openAnimation

		NumberAnimation {
			target: panel
			property: "y"
			from: -root.slideDistance
			to: 0
			duration: 200
			easing.type: Easing.OutCubic
		}

		NumberAnimation {
			target: panel
			property: "opacity"
			from: 0
			to: 1
			duration: 200
		}
		
		onFinished: root.expanded = true
	}

	ParallelAnimation {
		id: closeAnimation

		NumberAnimation {
			target: panel
			property: "y"
			to: -root.slideDistance
			duration: 200
			easing.type: Easing.OutCubic
		}

		NumberAnimation {
			target: panel
			property: "opacity"
			to: 0
			duration: 200
		}
		
		onFinished: root.visible = false
	}
}
