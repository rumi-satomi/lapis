import QtQuick
import QtQuick.Layouts

import "../singletons/"

RowLayout {
	spacing: Theme.spacing

	Workspaces {
		//Layout.maximumWidth: 200
	}

	CreateWorkspaceButton {}

	Item {
		Layout.fillWidth: true
	}

	SettingsButton {}

	Battery {}

	Clock {}
}
