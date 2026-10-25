import QtQuick
import QtQuick.Layouts

import "../singletons/"

RowLayout {
	spacing: Theme.spacing

	Clock {}

	Item {
		Layout.fillWidth: true
	}

	SettingsButton {}

	Battery {}
}
