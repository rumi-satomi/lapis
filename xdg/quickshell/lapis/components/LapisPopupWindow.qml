import QtQuick
import QtQuick.Controls.Basic as Controls
import Quickshell

import "../singletons"

PopupWindow {
	id: root

	required property Item anchorItem

	property alias body: frame.contentItem

	property int padding: 12
	property int slideDistance: 16

	property bool closing: false
	property real reveal: 0

	property bool wasShown: false

	signal dismissed()

	color: "transparent"
	visible: false

	implicitWidth: frame.implicitContentWidth + 2 * padding
	implicitHeight: frame.implicitContentHeight + 2 * padding

	anchor.item: root.anchorItem

	anchor.rect.x: (root.anchorItem.width - root.implicitWidth) / 2
	anchor.rect.y: root.anchorItem.height + Theme.spacing

	function open() {
		PopupManager.open(root)
	}

	function toggle() {
		PopupManager.toggle(root)
	}

	function close() {
		hideAnimated()
	}

	function showAnimated() {
		if (visible && !closing) return
		motion.stop()
		closing = false
		visible = true

		motion.to = 1
		motion.duration = 200
		motion.start()
	}

	function hideAnimated() {
		if (!visible) {
			PopupManager.release(root)
			return
		}

		if (closing) return

		motion.stop()
		closing = true

		motion.to = 0
		motion.duration = 160
		motion.start()
	}

	onVisibleChanged: {
		if (!visible) {
			wasShown = true
			return
		}

		motion.stop()
		reveal = 0
		closing = false

		PopupManager.release(root)

		if (wasShown) {
			wasShown = false
			dismissed()
		}
	}

	onClosed: root.visible = false

	onAnchorItemChanged: {
		if (!anchorItem && visible) visible = false
	}

	Component.onDestruction: PopupManager.release(root)

	Controls.Control {
		id: frame

		width: root.width
		height: root.height
		padding: root.padding

		y: -root.slideDistance * (1 - root.reveal)

		opacity: root.reveal

		background: Rectangle {
			radius: Theme.radius
			color: Theme.surface2
		}
	}

	NumberAnimation {
		id: motion

		target: root
		property: "reveal"
		easing.type: Easing.OutCubic

		onFinished: {
			if (root.closing) root.visible = false
		}
	}
}
