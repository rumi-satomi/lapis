pragma Singleton

import QtQuick
import Quickshell

Singleton {
	id: root

	property var current: null
	property var pending: null

	function open(popup) {
		if (!popup || !popup.anchorItem || !popup.anchorItem.visible) return

		if (current === popup) {
			pending = null
			popup.showAnimated()
			return
		}

		pending = popup

		if (current) {
			current.hideAnimated()
		} else {
			openPending()
		}
	}

	function toggle(popup) {
		if (current === popup && !popup.closing) {
			pending = null
			popup.hideAnimated()
		} else {
			open(popup)
		}
	}

	function close(popup) {
		if (pending === popup) pending = null
		if (current === popup) popup.hideAnimated()
	}

	function release(popup) {
		if (pending === popup) pending = null
		if (current !== popup) return
		current = null
		Qt.callLater(root.openPending)
	}

	function openPending() {
		if (current || !pending) return
		
		const popup = pending
		pending = null

		if (!popup.anchorItem || !popup.anchorItem.visible) return

		current = popup
		popup.showAnimated()
		console.info("Opened popup " + current)
	}
}
