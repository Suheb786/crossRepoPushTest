#include "include/infobipplugin/infobipplugin_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "infobipplugin_plugin.h"

void InfobippluginPluginCApiRegisterWithRegistrar(
        FlutterDesktopPluginRegistrarRef registrar) {
    infobipplugin::InfobippluginPlugin::RegisterWithRegistrar(
            flutter::PluginRegistrarManager::GetInstance()
                    ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
