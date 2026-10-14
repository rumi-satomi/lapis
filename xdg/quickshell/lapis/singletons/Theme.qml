pragma Singleton

import QtQuick
import Quickshell

Singleton {
	readonly property color background: "#121212"
	readonly property color surface1: "#1E1E1E"
	readonly property color surface2: "#222222"
	readonly property color surface3: "#272727"

	readonly property color primary: "#BB86FC"
	readonly property color secondary: "#03DAC6"
	readonly property color error: "#CF6679"

	readonly property color primaryForeground: "#000000"
	readonly property color secondaryForeground: "#000000"
	readonly property color errorForeground: "#000000"
	readonly property color backgroundForeground: "#FFFFFF"
	readonly property color surfaceForeground: "#FFFFFF"

	readonly property int radius: 8
	readonly property int spacing: 8

	readonly property int barHeight: 32

	readonly property string fontFamily: "Noto Sans"
	readonly property int fontSize: 13
}
