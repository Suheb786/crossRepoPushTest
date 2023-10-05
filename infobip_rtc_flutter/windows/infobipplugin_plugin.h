#ifndef FLUTTER_PLUGIN_INFOBIPPLUGIN_PLUGIN_H_
#define FLUTTER_PLUGIN_INFOBIPPLUGIN_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace infobipplugin {

    class InfobippluginPlugin : public flutter::Plugin {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        InfobippluginPlugin();

        virtual ~InfobippluginPlugin();

        // Disallow copy and assign.
        InfobippluginPlugin(const InfobippluginPlugin &) = delete;

        InfobippluginPlugin &operator=(const InfobippluginPlugin &) = delete;

        // Called when a method is called on this plugin's channel from Dart.
        void HandleMethodCall(
                const flutter::MethodCall <flutter::EncodableValue> &method_call,
                std::unique_ptr <flutter::MethodResult<flutter::EncodableValue>> result);
    };

}  // namespace infobipplugin

#endif  // FLUTTER_PLUGIN_INFOBIPPLUGIN_PLUGIN_H_
