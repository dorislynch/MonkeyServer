using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Monkey.Server.RNMonkeyServer
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNMonkeyServerModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNMonkeyServerModule"/>.
        /// </summary>
        internal RNMonkeyServerModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNMonkeyServer";
            }
        }
    }
}
