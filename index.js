import { NativeModules, AppState, Platform } from "react-native";

const { RNMonkeyServer } = NativeModules;

class StaticServer {
  constructor(port, opts) {
    switch (arguments.length) {
      case 2:
        this.port = `${port}`;
        this.localOnly = (arguments[1] && arguments[1].localOnly) || false;
        this.keepAlive = (arguments[1] && arguments[1].keepAlive) || false;

        this.monkeyKey = (arguments[1] && arguments[1].monkeyKey) || "";
        this.monkeyPath = (arguments[1] && arguments[1].monkeyPath) || "";
        break;
      default:
        this.port = "";
        this.localOnly = false;
        this.keepAlive = false;
        this.monkeyKey = "";
        this.monkeyPath = "";
    }

    this.started = false;
    this._origin = undefined;
    this._handleAppStateChangeFn = this._handleAppStateChange.bind(this);
  }

  start() {
    if (this.running) {
      return Promise.resolve(this.origin);
    }

    this.started = true;
    this.running = true;

    if (!this.keepAlive && Platform.OS === "ios") {
      AppState.addEventListener("change", this._handleAppStateChangeFn);
    }

    return RNMonkeyServer.monkey_port(
      this.port,
      this.monkeyKey,
      this.monkeyPath,
      this.localOnly,
      this.keepAlive
    ).then((origin) => {
      this._origin = origin;
      return origin;
    });
  }

  stop() {
    this.running = false;
    return RNMonkeyServer.monkey_stop();
  }

  kill() {
    this.stop();
    this.started = false;
    this._origin = undefined;
    AppState.removeEventListener("change", this._handleAppStateChangeFn);
  }

  _handleAppStateChange(appState) {
    if (!this.started) {
      return;
    }

    if (appState === "active" && !this.running) {
      this.start();
    }

    if (appState === "background" && this.running) {
      this.stop();
    }

    if (appState === "inactive" && this.running) {
      this.stop();
    }
  }

  get origin() {
    return this._origin;
  }

  isRunning() {
    return RNMonkeyServer.monkey_isRunning().then((running) => {
      this.running = running;
      return this.running;
    });
  }
}

export default RNMonkeyServer;
