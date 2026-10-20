pragma Singleton

import QtQuick
import Quickshell

Singleton {
	id: root

	readonly property string libexecDir: Quickshell.shellDir + "/../../../runtime/libexec"
	readonly property string wvkbd: libexecDir + "/wvkbd-lapis"
	readonly property string lisgd: libexecDir + "/lisgd"
}
