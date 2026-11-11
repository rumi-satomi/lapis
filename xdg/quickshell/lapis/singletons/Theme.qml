pragma Singleton

import QtQuick
import Quickshell

Singleton {
	readonly property color background: "#121212"
	readonly property color surfaceTint: Qt.rgba(1, 1, 1, 0.05)

	function toWvkbdColor(color) {
		const hex = color.toString().slice(1)
		return hex.length === 8 ? hex.slice(2) + hex.slice(0, 2) : hex
	}

	readonly property string backgroundWVKBD: toWvkbdColor(background)
	readonly property string surfaceTintWVKBD: toWvkbdColor(Qt.rgba(
		surfaceTint.r * surfaceTint.a + background.r * (1 - surfaceTint.a),
		surfaceTint.g * surfaceTint.a + background.g * (1 - surfaceTint.a),
		surfaceTint.b * surfaceTint.a + background.b * (1 - surfaceTint.a),
	))

	readonly property color primary: "#BB86FC"
	readonly property color secondary: "#03DAC6"
	readonly property color error: "#CF6679"

	readonly property color primaryForeground: "#000000"
	readonly property color secondaryForeground: "#000000"
	readonly property color errorForeground: "#000000"
	readonly property color backgroundForeground: "#FFFFFF"
	readonly property color surfaceForeground: "#FFFFFF"

	readonly property int radius: 8
	readonly property int spacing: 6

	readonly property int barHeight: 40
	readonly property int barSpacingVertical: 4
	readonly property int barItemHeight: barHeight - 2 * barSpacingVertical

	readonly property string fontFamily: "Noto Sans"
	readonly property int fontSize: 16
}
